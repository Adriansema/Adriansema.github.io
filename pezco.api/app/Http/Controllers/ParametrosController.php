<?php

namespace App\Http\Controllers;

use App\Models\Parametro;
use App\Models\Camada;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ParametrosController extends Controller
{
  // Solo administrador ve todos los parametros
  public function index(): JsonResponse
  {
    $parametros = Parametro::with(['camada.estanque', 'camada.especie'])->get();

    return response()->json([
      'parametros' => $parametros
    ], 200);
  }

  // Administrador ve cualquier parametro, usuario solo los suyos
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $parametro = Parametro::with(['camada.estanque', 'camada.especie'])->find($id);

    if (!$parametro) {
      return response()->json([
        'mensaje' => 'Parametro no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $parametro->camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este parametro'
        ], 403);
      }
    }

    return response()->json([
      'parametro' => $parametro
    ], 200);
  }

  // El usuario registra un parametro para una camada
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'camada_id'       => 'required|integer|exists:camadas,id',
      'muertes'         => 'nullable|integer|min:0',
      'peso_individual' => 'nullable|numeric|min:0',
      'peso_colectivo'  => 'nullable|numeric|min:0',
      'temperatura'     => 'nullable|numeric',
      'ph'              => 'nullable|numeric|min:0|max:14',
      'alcalinidad'     => 'nullable|numeric|min:0',
      'dureza'          => 'nullable|numeric|min:0',
      'amonio'          => 'nullable|numeric|min:0',
      'nitrito'         => 'nullable|numeric|min:0',
      'nitrato'         => 'nullable|numeric|min:0',
      'fecha_medicion'  => 'required|date',
    ]);

    // Verificar que la camada pertenece al usuario
    $camada = Camada::with('estanque')->find($validated['camada_id']);

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'Esta camada no te pertenece'
        ], 403);
      }
    }

    // Calcular numero de medicion automaticamente
    $nMedicion = Parametro::where('camada_id', $validated['camada_id'])->count() + 1;

    // Si hay muertes registradas, actualizar el contador en la camada
    if (isset($validated['muertes']) && $validated['muertes'] > 0) {
      $camada->increment('cantidad_muertes', $validated['muertes']);
    }

    $parametro = Parametro::create([
      'camada_id'       => $validated['camada_id'],
      'n_medicion'      => $nMedicion,
      'muertes'         => $validated['muertes'] ?? 0,
      'peso_individual' => $validated['peso_individual'] ?? null,
      'peso_colectivo'  => $validated['peso_colectivo'] ?? null,
      'temperatura'     => $validated['temperatura'] ?? null,
      'ph'              => $validated['ph'] ?? null,
      'alcalinidad'     => $validated['alcalinidad'] ?? null,
      'dureza'          => $validated['dureza'] ?? null,
      'amonio'          => $validated['amonio'] ?? null,
      'nitrito'         => $validated['nitrito'] ?? null,
      'nitrato'         => $validated['nitrato'] ?? null,
      'fecha_medicion'  => $validated['fecha_medicion'],
    ]);

    // Verificar alertas de parametros fuera de rango
    $alertas = $this->verificarAlertas($parametro, $camada);

    return response()->json([
      'mensaje'   => 'Parametro registrado exitosamente',
      'parametro' => $parametro->load(['camada.especie']),
      'alertas'   => $alertas,
    ], 201);
  }

  // Actualizar un parametro registrado
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $parametro = Parametro::with(['camada.estanque'])->find($id);

    if (!$parametro) {
      return response()->json([
        'mensaje' => 'Parametro no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $parametro->camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este parametro'
        ], 403);
      }
    }

    $validated = $request->validate([
      'muertes'         => 'sometimes|integer|min:0',
      'peso_individual' => 'sometimes|numeric|min:0',
      'peso_colectivo'  => 'sometimes|numeric|min:0',
      'temperatura'     => 'sometimes|numeric',
      'ph'              => 'sometimes|numeric|min:0|max:14',
      'alcalinidad'     => 'sometimes|numeric|min:0',
      'dureza'          => 'sometimes|numeric|min:0',
      'amonio'          => 'sometimes|numeric|min:0',
      'nitrito'         => 'sometimes|numeric|min:0',
      'nitrato'         => 'sometimes|numeric|min:0',
      'fecha_medicion'  => 'sometimes|date',
    ]);

    $parametro->update($validated);

    return response()->json([
      'mensaje'   => 'Parametro actualizado exitosamente',
      'parametro' => $parametro
    ], 200);
  }

  // Solo administrador elimina parametros
  public function destroy(int $id): JsonResponse
  {
    $parametro = Parametro::find($id);

    if (!$parametro) {
      return response()->json([
        'mensaje' => 'Parametro no encontrado'
      ], 404);
    }

    $parametro->delete();

    return response()->json([
      'mensaje' => 'Parametro eliminado exitosamente'
    ], 200);
  }

  // Verifica si los parametros estan fuera del rango optimo de la especie
  private function verificarAlertas(Parametro $parametro, Camada $camada): array
  {
    $alertas = [];
    $especie  = $camada->especie;

    if (!$especie) {
      return $alertas;
    }

    if ($parametro->temperatura !== null) {
      if ($especie->temperatura_min && $parametro->temperatura < $especie->temperatura_min) {
        $alertas[] = "Temperatura por debajo del minimo recomendado ({$especie->temperatura_min}°C)";
      }
      if ($especie->temperatura_max && $parametro->temperatura > $especie->temperatura_max) {
        $alertas[] = "Temperatura por encima del maximo recomendado ({$especie->temperatura_max}°C)";
      }
    }

    if ($parametro->ph !== null) {
      if ($especie->ph_min && $parametro->ph < $especie->ph_min) {
        $alertas[] = "pH por debajo del minimo recomendado ({$especie->ph_min})";
      }
      if ($especie->ph_max && $parametro->ph > $especie->ph_max) {
        $alertas[] = "pH por encima del maximo recomendado ({$especie->ph_max})";
      }
    }

    return $alertas;
  }
}
