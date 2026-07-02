<?php

namespace App\Http\Controllers;

use App\Models\Licencia;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class LicenciaController extends Controller
{
  /**
   * Display a listing of the resource.
   */
  public function index(): JsonResponse
  {
    $licencias = Licencia::all();

    return response()->json([
      'licencias' => $licencias
    ], 200);
  }

  /**
   * Store a newly created resource in storage.
   */
  public function store(Request $request): JsonResponse
  {
    $validated = $request->validate([
      'nombre'       => 'required|string|max:100',
      'tipo'         => 'required|string|max:50',
      'descripcion'  => 'nullable|string',
      'estanques'    => 'required|integer|min:1',
      'soporte'      => 'required|string|max:100',
      'duracion_mes' => 'required|integer|min:1',
      'precio_mes'   => 'required|numeric|min:0',
      'precio_anual' => 'required|numeric|min:0',
      'tipo_cambio'  => 'nullable|string|max:10',
    ]);

    $licencia = Licencia::create($validated);

    return response()->json([
      'mensaje' => 'Licencia creada exitosamente',
      'licencia' => $licencia
    ], 201);
  }

  /**
   * Display the specified resource.
   */
  public function show(int $id): JsonResponse
  {
    $licencia = Licencia::find($id);

    if (!$licencia) {
      return response()->json([
        'mensaje' => 'Licencia no encontrada'
      ], 404);
    }

    return response()->json([
      'licencia' => $licencia
    ], 200);
  }

  /**
   * Update the specified resource in storage.
   */
  public function update(Request $request, int $id): JsonResponse
  {
    $licencia = Licencia::find($id);

    if (!$licencia) {
      return response()->json([
        'mensaje' => 'Licencia no encontrada'
      ], 404);
    }

    $validated = $request->validate([
      'nombre'       => 'sometimes|string|max:100',
      'tipo'         => 'sometimes|string|max:50',
      'descripcion'  => 'sometimes|nullable|string',
      'estanques'    => 'sometimes|integer|min:1',
      'soporte'      => 'sometimes|string|max:100',
      'duracion_mes' => 'sometimes|integer|min:1',
      'precio_mes'   => 'sometimes|numeric|min:0',
      'precio_anual' => 'sometimes|numeric|min:0',
      'tipo_cambio'  => 'sometimes|nullable|string|max:10',
    ]);

    $licencia->update($validated);

    return response()->json([
      'mensaje'  => 'Licencia actualizada exitosamente',
      'licencia' => $licencia
    ], 200);
  }

  /**
   * Remove the specified resource from storage.
   */
  public function destroy(int $id): JsonResponse
  {
    $licencia = Licencia::find($id);

    if (!$licencia) {
      return response()->json([
        'mensaje' => 'Licencia no encontrada'
      ], 404);
    }

    $licencia->delete();

    return response()->json([
      'mensaje' => 'Licencia eliminada exitosamente'
    ], 200);
  }
}
