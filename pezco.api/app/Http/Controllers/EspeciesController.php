<?php

namespace App\Http\Controllers;

use App\Models\Especie;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class EspeciesController extends Controller
{
  // Cualquier usuario autenticado puede ver las especies
  public function index(): JsonResponse
  {
    $especies = Especie::all();

    return response()->json([
      'especies' => $especies
    ], 200);
  }

  // Cualquier usuario autenticado puede ver el detalle de una especie
  public function show(int $id): JsonResponse
  {
    $especie = Especie::find($id);

    if (!$especie) {
      return response()->json([
        'mensaje' => 'Especie no encontrada'
      ], 404);
    }

    return response()->json([
      'especie' => $especie
    ], 200);
  }

  // Solo administrador puede crear especies
  public function store(Request $request): JsonResponse
  {
    $validated = $request->validate([
      'nombre'              => 'required|string|max:100|unique:especies,nombre',
      'nombre_cientifico'   => 'nullable|string|max:150',
      'descripcion'         => 'nullable|string',
      'dias_alevin'         => 'required|integer|min:1',
      'dias_juvenil'        => 'required|integer|min:1',
      'dias_adulto'         => 'required|integer|min:1',
      'dias_reproductor'    => 'required|integer|min:1',
      'peso_optimo_cosecha' => 'required|numeric|min:0',
      'temperatura_min'     => 'nullable|numeric',
      'temperatura_max'     => 'nullable|numeric',
      'ph_min'              => 'nullable|numeric|min:0|max:14',
      'ph_max'              => 'nullable|numeric|min:0|max:14',
    ]);

    // Validar que los rangos sean coherentes
    if (isset($validated['temperatura_min']) && isset($validated['temperatura_max'])) {
      if ($validated['temperatura_min'] >= $validated['temperatura_max']) {
        return response()->json([
          'mensaje' => 'La temperatura minima debe ser menor que la maxima'
        ], 422);
      }
    }

    if (isset($validated['ph_min']) && isset($validated['ph_max'])) {
      if ($validated['ph_min'] >= $validated['ph_max']) {
        return response()->json([
          'mensaje' => 'El pH minimo debe ser menor que el pH maximo'
        ], 422);
      }
    }

    $especie = Especie::create($validated);

    return response()->json([
      'mensaje' => 'Especie creada exitosamente',
      'especie' => $especie
    ], 201);
  }

  // Solo administrador puede actualizar especies
  public function update(Request $request, int $id): JsonResponse
  {
    $especie = Especie::find($id);

    if (!$especie) {
      return response()->json([
        'mensaje' => 'Especie no encontrada'
      ], 404);
    }

    $validated = $request->validate([
      'nombre'              => 'sometimes|string|max:100|unique:especies,nombre,' . $id,
      'nombre_cientifico'   => 'sometimes|nullable|string|max:150',
      'descripcion'         => 'sometimes|nullable|string',
      'dias_alevin'         => 'sometimes|integer|min:1',
      'dias_juvenil'        => 'sometimes|integer|min:1',
      'dias_adulto'         => 'sometimes|integer|min:1',
      'dias_reproductor'    => 'sometimes|integer|min:1',
      'peso_optimo_cosecha' => 'sometimes|numeric|min:0',
      'temperatura_min'     => 'sometimes|nullable|numeric',
      'temperatura_max'     => 'sometimes|nullable|numeric',
      'ph_min'              => 'sometimes|nullable|numeric|min:0|max:14',
      'ph_max'              => 'sometimes|nullable|numeric|min:0|max:14',
    ]);

    // Validar rangos coherentes tomando valores actuales si no vienen en el request
    $tempMin = $validated['temperatura_min'] ?? $especie->temperatura_min;
    $tempMax = $validated['temperatura_max'] ?? $especie->temperatura_max;

    if ($tempMin !== null && $tempMax !== null) {
      if ($tempMin >= $tempMax) {
        return response()->json([
          'mensaje' => 'La temperatura minima debe ser menor que la maxima'
        ], 422);
      }
    }

    $phMin = $validated['ph_min'] ?? $especie->ph_min;
    $phMax = $validated['ph_max'] ?? $especie->ph_max;

    if ($phMin !== null && $phMax !== null) {
      if ($phMin >= $phMax) {
        return response()->json([
          'mensaje' => 'El pH minimo debe ser menor que el pH maximo'
        ], 422);
      }
    }

    $especie->update($validated);

    return response()->json([
      'mensaje' => 'Especie actualizada exitosamente',
      'especie' => $especie
    ], 200);
  }

  // Solo administrador puede eliminar especies
  public function destroy(int $id): JsonResponse
  {
    $especie = Especie::find($id);

    if (!$especie) {
      return response()->json([
        'mensaje' => 'Especie no encontrada'
      ], 404);
    }

    // Verificar que no haya camadas usando esta especie
    if ($especie->camadas()->count() > 0) {
      return response()->json([
        'mensaje' => 'No se puede eliminar la especie porque tiene camadas asociadas'
      ], 422);
    }

    $especie->delete();

    return response()->json([
      'mensaje' => 'Especie eliminada exitosamente'
    ], 200);
  }
}
