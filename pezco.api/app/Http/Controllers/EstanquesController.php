<?php

namespace App\Http\Controllers;

use App\Models\Estanque;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EstanquesController extends Controller
{
  public function index(): JsonResponse
  {
    $estanques = Estanque::with('usuario')->get();

    return response()->json([
      'estanques' => $estanques
    ], 200);
  }

  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $estanque = Estanque::with('usuario')->find($id);

    if (!$estanque) {
      return response()->json([
        'mensaje' => 'Estanque no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este estanque'
        ], 403);
      }
    }

    return response()->json([
      'estanque' => $estanque
    ], 200);
  }

  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'nombre'       => 'required|string|max:100',
      'm_frente'     => 'required|numeric|min:0',
      'm_fondo'      => 'required|numeric|min:0',
      'm_profundo'   => 'required|numeric|min:0',
      'tipo_estanque' => 'required|string|in:geomembrana,cemento,plastico,tierra,fibra',
      'fecha'        => 'required|date',
    ]);

    // Calcular metros cubicos automaticamente
    $mCubicos = $validated['m_frente'] * $validated['m_fondo'] * $validated['m_profundo'];

    // Calcular capacidades por etapa segun metros cubicos
    // Densidades aproximadas estandar en acuicultura
    $capacidades = $this->calcularCapacidades($mCubicos);

    // Calcular fechas de mantenimiento y vida util segun tipo de estanque
    $fechas = $this->calcularFechas($validated['tipo_estanque'], $validated['fecha']);

    $estanque = Estanque::create([
      'usuario_id'              => $usuarioAutenticado->usuario_id,
      'nombre'                  => $validated['nombre'],
      'm_frente'                => $validated['m_frente'],
      'm_fondo'                 => $validated['m_fondo'],
      'm_profundo'              => $validated['m_profundo'],
      'm_cubicos'               => $mCubicos,
      'capacidad_alevin'        => $capacidades['alevin'],
      'capacidad_juvenil'       => $capacidades['juvenil'],
      'capacidad_adulto'        => $capacidades['adulto'],
      'capacidad_reproductor'   => $capacidades['reproductor'],
      'tipo_estanque'           => $validated['tipo_estanque'],
      'fecha_mantenimiento'     => $fechas['mantenimiento'],
      'fecha_vida_util'         => $fechas['vida_util'],
      'fecha'                   => $validated['fecha'],
      'estado'                  => 'activo',
    ]);

    return response()->json([
      'mensaje'  => 'Estanque creado exitosamente',
      'estanque' => $estanque
    ], 201);
  }

  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $estanque = Estanque::find($id);

    if (!$estanque) {
      return response()->json([
        'mensaje' => 'Estanque no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este estanque'
        ], 403);
      }
    }

    $validated = $request->validate([
      'nombre'        => 'sometimes|string|max:100',
      'm_frente'      => 'sometimes|numeric|min:0',
      'm_fondo'       => 'sometimes|numeric|min:0',
      'm_profundo'    => 'sometimes|numeric|min:0',
      'tipo_estanque' => 'sometimes|string|in:geomembrana,cemento,plastico,tierra,fibra',
      'fecha'         => 'sometimes|date',
      'estado'        => 'sometimes|string|in:activo,inactivo,mantenimiento',
    ]);

    // Si cambian las medidas, recalcular metros cubicos y capacidades
    $mFrente   = $validated['m_frente']   ?? $estanque->m_frente;
    $mFondo    = $validated['m_fondo']    ?? $estanque->m_fondo;
    $mProfundo = $validated['m_profundo'] ?? $estanque->m_profundo;

    if (isset($validated['m_frente']) || isset($validated['m_fondo']) || isset($validated['m_profundo'])) {
      $mCubicos                        = $mFrente * $mFondo * $mProfundo;
      $capacidades                     = $this->calcularCapacidades($mCubicos);
      $validated['m_cubicos']          = $mCubicos;
      $validated['capacidad_alevin']   = $capacidades['alevin'];
      $validated['capacidad_juvenil']  = $capacidades['juvenil'];
      $validated['capacidad_adulto']   = $capacidades['adulto'];
      $validated['capacidad_reproductor'] = $capacidades['reproductor'];
    }

    // Si cambia el tipo de estanque, recalcular fechas
    if (isset($validated['tipo_estanque'])) {
      $fecha                           = $validated['fecha'] ?? $estanque->fecha;
      $fechas                          = $this->calcularFechas($validated['tipo_estanque'], $fecha);
      $validated['fecha_mantenimiento'] = $fechas['mantenimiento'];
      $validated['fecha_vida_util']    = $fechas['vida_util'];
    }

    $estanque->update($validated);

    return response()->json([
      'mensaje'  => 'Estanque actualizado exitosamente',
      'estanque' => $estanque
    ], 200);
  }

  public function destroy(int $id): JsonResponse
  {
    $estanque = Estanque::find($id);

    if (!$estanque) {
      return response()->json([
        'mensaje' => 'Estanque no encontrado'
      ], 404);
    }

    $estanque->delete();

    return response()->json([
      'mensaje' => 'Estanque eliminado exitosamente'
    ], 200);
  }

  private function calcularCapacidades(float $mCubicos): array
  {
    // Densidades estandar en acuicultura (ejemplares por metro cubico)
    return [
      'alevin'      => (int) ($mCubicos * 500),
      'juvenil'     => (int) ($mCubicos * 100),
      'adulto'      => (int) ($mCubicos * 30),
      'reproductor' => (int) ($mCubicos * 5),
    ];
  }

  private function calcularFechas(string $tipoEstanque, string $fecha): array
  {
    $fechaBase = \Carbon\Carbon::parse($fecha);

    $configuracion = [
      'geomembrana' => ['mantenimiento_meses' => 12, 'vida_util_anos' => 10],
      'cemento'     => ['mantenimiento_meses' => 18, 'vida_util_anos' => 25],
      'plastico'    => ['mantenimiento_meses' => 6,  'vida_util_anos' => 5],
      'tierra'      => ['mantenimiento_meses' => 3,  'vida_util_anos' => 15],
      'fibra'       => ['mantenimiento_meses' => 12, 'vida_util_anos' => 15],
    ];

    $config = $configuracion[$tipoEstanque];

    return [
      'mantenimiento' => $fechaBase->copy()->addMonths($config['mantenimiento_meses']),
      'vida_util'     => $fechaBase->copy()->addYears($config['vida_util_anos']),
    ];
  }
}
