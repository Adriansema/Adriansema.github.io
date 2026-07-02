<?php

namespace App\Http\Controllers;

use App\Models\Finanza;
use App\Models\Camada;
use App\Models\Estanque;
use App\Models\Suministro;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class FinanzasController extends Controller
{
  // Solo administrador ve todos los informes
  public function index(): JsonResponse
  {
    $finanzas = Finanza::with(['usuario', 'camada.especie', 'estanque'])->get();

    return response()->json([
      'finanzas' => $finanzas
    ], 200);
  }

  // Administrador ve cualquier informe, usuario solo los suyos
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $finanza = Finanza::with(['usuario', 'camada.especie', 'estanque'])->find($id);

    if (!$finanza) {
      return response()->json([
        'mensaje' => 'Informe no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $finanza->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este informe'
        ], 403);
      }
    }

    return response()->json([
      'finanza' => $finanza
    ], 200);
  }

  // Generar informe financiero automaticamente
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'tipo_informe' => 'required|string|in:general,por_estanque,por_camada',
      'camada_id'    => 'nullable|integer|exists:camadas,id',
      'estanque_id'  => 'nullable|integer|exists:estanques,id',
    ]);

    // Validar que los campos requeridos esten presentes segun tipo de informe
    if ($validated['tipo_informe'] === 'por_camada' && !isset($validated['camada_id'])) {
      return response()->json([
        'mensaje' => 'El informe por camada requiere camada_id'
      ], 422);
    }

    if ($validated['tipo_informe'] === 'por_estanque' && !isset($validated['estanque_id'])) {
      return response()->json([
        'mensaje' => 'El informe por estanque requiere estanque_id'
      ], 422);
    }

    // Calcular datos financieros segun tipo de informe
    $datos = $this->calcularDatos(
      $usuarioAutenticado->usuario_id,
      $validated['tipo_informe'],
      $validated['camada_id'] ?? null,
      $validated['estanque_id'] ?? null
    );

    if (!$datos) {
      return response()->json([
        'mensaje' => 'No hay datos suficientes para generar el informe'
      ], 422);
    }

    $finanza = Finanza::create([
      'usuario_id'         => $usuarioAutenticado->usuario_id,
      'camada_id'          => $validated['camada_id'] ?? $datos['camada_id'],
      'estanque_id'        => $validated['estanque_id'] ?? $datos['estanque_id'],
      'fecha_emision'      => now(),
      'ingresos_brutos'    => $datos['ingresos_brutos'],
      'costo_insumos'      => $datos['costo_insumos'],
      'perdidas'           => $datos['perdidas'],
      'rentabilidad_neta'  => $datos['rentabilidad_neta'],
      'precio_comercial'   => $datos['precio_comercial'],
      'cantidad_vendida'   => $datos['cantidad_vendida'],
      'cantidad_muertes'   => $datos['cantidad_muertes'],
      'cantidad_no_vendida' => $datos['cantidad_no_vendida'],
      'tipo_informe'       => $validated['tipo_informe'],
    ]);

    return response()->json([
      'mensaje' => 'Informe financiero generado exitosamente',
      'finanza' => $finanza->load(['camada.especie', 'estanque']),
      'detalle' => $datos['detalle'],
    ], 201);
  }

  // Solo administrador elimina informes
  public function destroy(int $id): JsonResponse
  {
    $finanza = Finanza::find($id);

    if (!$finanza) {
      return response()->json([
        'mensaje' => 'Informe no encontrado'
      ], 404);
    }

    $finanza->delete();

    return response()->json([
      'mensaje' => 'Informe eliminado exitosamente'
    ], 200);
  }

  // Calcula todos los datos financieros segun el tipo de informe
  private function calcularDatos(
    int $usuarioId,
    string $tipoInforme,
    ?int $camadaId,
    ?int $estanqueId
  ): ?array {
    // Obtener camadas segun tipo de informe
    $camadas = match ($tipoInforme) {
      'por_camada'   => Camada::with(['estanque', 'especie'])
        ->where('id', $camadaId)
        ->whereIn('estanque_id', function ($q) use ($usuarioId) {
          $q->select('id')->from('estanques')
            ->where('usuario_id', $usuarioId);
        })->get(),

      'por_estanque' => Camada::with(['estanque', 'especie'])
        ->where('estanque_id', $estanqueId)
        ->whereHas('estanque', function ($q) use ($usuarioId) {
          $q->where('usuario_id', $usuarioId);
        })->get(),

      'general'      => Camada::with(['estanque', 'especie'])
        ->whereHas('estanque', function ($q) use ($usuarioId) {
          $q->where('usuario_id', $usuarioId);
        })->get(),
    };

    if ($camadas->isEmpty()) {
      return null;
    }

    $totalIngresosBrutos  = 0;
    $totalCostoInsumos    = 0;
    $totalPerdidas        = 0;
    $totalVendidos        = 0;
    $totalMuertes         = 0;
    $totalNoVendidos      = 0;
    $detalle              = [];

    foreach ($camadas as $camada) {
      $precioComercial  = $camada->precio_comercial ?? 0;
      $cantidadVendida  = $camada->cantidad_salida;
      $cantidadMuertes  = $camada->cantidad_muertes;
      $cantidadNoVendida = $camada->cantidad_no_vendida;

      // Ingresos brutos = cantidad vendida x precio comercial
      $ingresosBrutos = $cantidadVendida * $precioComercial;

      // Costo insumos = suma de (cantidad suministrada x costo unitario del insumo)
      $costoInsumos = Suministro::where('camada_id', $camada->id)
        ->with('insumo')
        ->get()
        ->sum(function ($suministro) {
          if (!$suministro->insumo || !$suministro->insumo->costo) {
            return 0;
          }
          // Costo proporcional segun cantidad suministrada
          $costoPorUnidad = $suministro->insumo->costo / $suministro->insumo->cantidad;
          return $costoPorUnidad * $suministro->cantidad;
        });

      // Perdidas = (muertes + no vendidos) x precio comercial
      $perdidas = ($cantidadMuertes + $cantidadNoVendida) * $precioComercial;

      $totalIngresosBrutos  += $ingresosBrutos;
      $totalCostoInsumos    += $costoInsumos;
      $totalPerdidas        += $perdidas;
      $totalVendidos        += $cantidadVendida;
      $totalMuertes         += $cantidadMuertes;
      $totalNoVendidos      += $cantidadNoVendida;

      $detalle[] = [
        'camada_id'        => $camada->id,
        'especie'          => $camada->especie->nombre ?? 'N/A',
        'estanque'         => $camada->estanque->nombre ?? 'N/A',
        'ingresos_brutos'  => round($ingresosBrutos, 2),
        'costo_insumos'    => round($costoInsumos, 2),
        'perdidas'         => round($perdidas, 2),
        'rentabilidad'     => round($ingresosBrutos - $costoInsumos - $perdidas, 2),
        'cantidad_vendida' => $cantidadVendida,
        'cantidad_muertes' => $cantidadMuertes,
      ];
    }

    $rentabilidadNeta = $totalIngresosBrutos - $totalCostoInsumos - $totalPerdidas;

    return [
      'camada_id'          => $camadaId ?? $camadas->first()->id,
      'estanque_id'        => $estanqueId ?? $camadas->first()->estanque_id,
      'ingresos_brutos'    => round($totalIngresosBrutos, 2),
      'costo_insumos'      => round($totalCostoInsumos, 2),
      'perdidas'           => round($totalPerdidas, 2),
      'rentabilidad_neta'  => round($rentabilidadNeta, 2),
      'precio_comercial'   => $camadas->first()->precio_comercial ?? 0,
      'cantidad_vendida'   => $totalVendidos,
      'cantidad_muertes'   => $totalMuertes,
      'cantidad_no_vendida' => $totalNoVendidos,
      'detalle'            => $detalle,
    ];
  }
}
