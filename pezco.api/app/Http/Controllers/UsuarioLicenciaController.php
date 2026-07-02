<?php

namespace App\Http\Controllers;

use App\Models\UsuarioLicencia;
use App\Models\Licencia;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UsuarioLicenciaController extends Controller
{
  // Solo administrador ve todas las licencias de todos los usuarios
  public function index(): JsonResponse
  {
    $usuarioLicencias = UsuarioLicencia::with(['usuario', 'licencia'])->get();

    return response()->json([
      'usuario_licencias' => $usuarioLicencias
    ], 200);
  }

  // Administrador ve cualquiera, usuario solo las suyas
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $usuarioLicencia = UsuarioLicencia::with(['usuario', 'licencia'])->find($id);

    if (!$usuarioLicencia) {
      return response()->json([
        'mensaje' => 'Licencia de usuario no encontrada'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->usuario_id !== $usuarioLicencia->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este registro'
        ], 403);
      }
    }

    return response()->json([
      'usuario_licencia' => $usuarioLicencia
    ], 200);
  }

  // El usuario adquiere una licencia
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    // El administrador no necesita licencia
    if ($usuarioAutenticado->rol === 'administrador') {
      return response()->json([
        'mensaje' => 'El administrador no requiere licencia'
      ], 403);
    }

    $validated = $request->validate([
      'licencia_id' => 'required|integer|exists:licencias,id',
    ]);

    // Verificar si el usuario ya tiene una licencia activa
    $licenciaActiva = UsuarioLicencia::where('usuario_id', $usuarioAutenticado->usuario_id)
      ->where('estado', 'activa')
      ->first();

    if ($licenciaActiva) {
      return response()->json([
        'mensaje' => 'Ya tienes una licencia activa'
      ], 422);
    }

    // Obtener la licencia para calcular la fecha de expiración
    $licencia = Licencia::find($validated['licencia_id']);

    $fechaEmision     = now();
    $fechaExpiracion  = now()->addMonths($licencia->duracion_mes);

    $usuarioLicencia = UsuarioLicencia::create([
      'usuario_id'       => $usuarioAutenticado->usuario_id,
      'licencia_id'      => $validated['licencia_id'],
      'fecha_emision'    => $fechaEmision,
      'fecha_expiracion' => $fechaExpiracion,
      'estado'           => 'activa',
    ]);

    return response()->json([
      'mensaje'           => 'Licencia adquirida exitosamente',
      'usuario_licencia'  => $usuarioLicencia->load(['licencia'])
    ], 201);
  }

  // Solo administrador puede actualizar el estado de una licencia
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioLicencia = UsuarioLicencia::find($id);

    if (!$usuarioLicencia) {
      return response()->json([
        'mensaje' => 'Licencia de usuario no encontrada'
      ], 404);
    }

    $validated = $request->validate([
      'estado' => 'required|string|in:activa,suspendida,expirada',
    ]);

    $usuarioLicencia->update($validated);

    return response()->json([
      'mensaje'          => 'Estado de licencia actualizado exitosamente',
      'usuario_licencia' => $usuarioLicencia
    ], 200);
  }

  // Solo administrador puede eliminar
  public function destroy(int $id): JsonResponse
  {
    $usuarioLicencia = UsuarioLicencia::find($id);

    if (!$usuarioLicencia) {
      return response()->json([
        'mensaje' => 'Licencia de usuario no encontrada'
      ], 404);
    }

    $usuarioLicencia->delete();

    return response()->json([
      'mensaje' => 'Licencia de usuario eliminada exitosamente'
    ], 200);
  }
}
