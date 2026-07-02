<?php

namespace App\Http\Controllers;

use App\Models\Suministro;
use App\Models\Insumo;
use App\Models\Camada;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SuministrosController extends Controller
{
  // Solo administrador ve todos los suministros
  public function index(): JsonResponse
  {
    $suministros = Suministro::with(['insumo', 'camada.estanque'])->get();

    return response()->json([
      'suministros' => $suministros
    ], 200);
  }

  // Administrador ve cualquier suministro, usuario solo los suyos
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $suministro = Suministro::with(['insumo', 'camada.estanque'])->find($id);

    if (!$suministro) {
      return response()->json([
        'mensaje' => 'Suministro no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $suministro->camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este suministro'
        ], 403);
      }
    }

    return response()->json([
      'suministro' => $suministro
    ], 200);
  }

  // El usuario registra un suministro aplicado a una camada
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'insumo_id'      => 'required|integer|exists:insumos,id',
      'camada_id'      => 'required|integer|exists:camadas,id',
      'cantidad'       => 'required|numeric|min:0',
      'unidad_metrica' => 'required|string|max:20',
      'fecha'          => 'required|date',
    ]);

    // Verificar que el insumo pertenece al usuario
    $insumo = Insumo::find($validated['insumo_id']);

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $insumo->usuario_id) {
        return response()->json([
          'mensaje' => 'Este insumo no te pertenece'
        ], 403);
      }
    }

    // Verificar que la camada pertenece al usuario
    $camada = Camada::with('estanque')->find($validated['camada_id']);

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'Esta camada no te pertenece'
        ], 403);
      }
    }

    // Verificar que hay suficiente cantidad disponible del insumo
    $cantidadUsada = Suministro::where('insumo_id', $validated['insumo_id'])
      ->sum('cantidad');

    $cantidadDisponible = $insumo->cantidad - $cantidadUsada;

    if ($validated['cantidad'] > $cantidadDisponible) {
      return response()->json([
        'mensaje'             => 'Cantidad insuficiente del insumo',
        'cantidad_disponible' => $cantidadDisponible,
        'unidad_metrica'      => $insumo->unidad_metrica,
      ], 422);
    }

    $suministro = Suministro::create([
      'insumo_id'      => $validated['insumo_id'],
      'camada_id'      => $validated['camada_id'],
      'cantidad'       => $validated['cantidad'],
      'unidad_metrica' => $validated['unidad_metrica'],
      'fecha'          => $validated['fecha'],
    ]);

    return response()->json([
      'mensaje'             => 'Suministro registrado exitosamente',
      'suministro'          => $suministro->load(['insumo', 'camada']),
      'cantidad_disponible' => $cantidadDisponible - $validated['cantidad'],
    ], 201);
  }

  // Actualizar un suministro registrado
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $suministro = Suministro::with(['insumo', 'camada.estanque'])->find($id);

    if (!$suministro) {
      return response()->json([
        'mensaje' => 'Suministro no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $suministro->camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este suministro'
        ], 403);
      }
    }

    $validated = $request->validate([
      'cantidad'       => 'sometimes|numeric|min:0',
      'unidad_metrica' => 'sometimes|string|max:20',
      'fecha'          => 'sometimes|date',
    ]);

    // Si cambia la cantidad verificar disponibilidad
    if (isset($validated['cantidad'])) {
      $cantidadUsada = Suministro::where('insumo_id', $suministro->insumo_id)
        ->where('id', '!=', $id)
        ->sum('cantidad');

      $cantidadDisponible = $suministro->insumo->cantidad - $cantidadUsada;

      if ($validated['cantidad'] > $cantidadDisponible) {
        return response()->json([
          'mensaje'             => 'Cantidad insuficiente del insumo',
          'cantidad_disponible' => $cantidadDisponible,
        ], 422);
      }
    }

    $suministro->update($validated);

    return response()->json([
      'mensaje'    => 'Suministro actualizado exitosamente',
      'suministro' => $suministro
    ], 200);
  }

  // Solo administrador elimina suministros
  public function destroy(int $id): JsonResponse
  {
    $suministro = Suministro::find($id);

    if (!$suministro) {
      return response()->json([
        'mensaje' => 'Suministro no encontrado'
      ], 404);
    }

    $suministro->delete();

    return response()->json([
      'mensaje' => 'Suministro eliminado exitosamente'
    ], 200);
  }
}
