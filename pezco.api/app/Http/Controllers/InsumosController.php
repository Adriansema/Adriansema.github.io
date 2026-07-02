<?php

namespace App\Http\Controllers;

use App\Models\Insumo;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class InsumosController extends Controller
{
  // Solo administrador ve todos los insumos de todos los usuarios
  public function index(): JsonResponse
  {
    $insumos = Insumo::with('usuario')->get();

    return response()->json([
      'insumos' => $insumos
    ], 200);
  }

  // Administrador ve cualquier insumo, usuario solo los suyos
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $insumo = Insumo::with('usuario')->find($id);

    if (!$insumo) {
      return response()->json([
        'mensaje' => 'Insumo no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $insumo->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este insumo'
        ], 403);
      }
    }

    return response()->json([
      'insumo' => $insumo
    ], 200);
  }

  // El usuario registra un insumo comprado
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'insumo'         => 'required|string|max:100',
      'cantidad'       => 'required|numeric|min:0',
      'unidad_metrica' => 'required|string|max:20',
      'costo'          => 'nullable|numeric|min:0',
      'fecha'          => 'required|date',
    ]);

    $insumo = Insumo::create([
      'usuario_id'     => $usuarioAutenticado->usuario_id,
      'insumo'         => $validated['insumo'],
      'cantidad'       => $validated['cantidad'],
      'unidad_metrica' => $validated['unidad_metrica'],
      'costo'          => $validated['costo'] ?? null,
      'fecha'          => $validated['fecha'],
    ]);

    return response()->json([
      'mensaje' => 'Insumo registrado exitosamente',
      'insumo'  => $insumo
    ], 201);
  }

  // Administrador o el propio usuario puede actualizar
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $insumo = Insumo::find($id);

    if (!$insumo) {
      return response()->json([
        'mensaje' => 'Insumo no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $insumo->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este insumo'
        ], 403);
      }
    }

    $validated = $request->validate([
      'insumo'         => 'sometimes|string|max:100',
      'cantidad'       => 'sometimes|numeric|min:0',
      'unidad_metrica' => 'sometimes|string|max:20',
      'costo'          => 'sometimes|nullable|numeric|min:0',
      'fecha'          => 'sometimes|date',
    ]);

    $insumo->update($validated);

    return response()->json([
      'mensaje' => 'Insumo actualizado exitosamente',
      'insumo'  => $insumo
    ], 200);
  }

  // Solo administrador elimina insumos
  public function destroy(int $id): JsonResponse
  {
    $insumo = Insumo::find($id);

    if (!$insumo) {
      return response()->json([
        'mensaje' => 'Insumo no encontrado'
      ], 404);
    }

    $insumo->delete();

    return response()->json([
      'mensaje' => 'Insumo eliminado exitosamente'
    ], 200);
  }
}
