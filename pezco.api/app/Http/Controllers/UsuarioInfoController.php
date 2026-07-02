<?php

namespace App\Http\Controllers;

use App\Models\UsuarioInfo;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UsuarioInfoController extends Controller
{
  // Solo administrador puede ver todos los perfiles
  public function index(): JsonResponse
  {
    $usuarios = UsuarioInfo::all();

    return response()->json([
      'usuarios' => $usuarios
    ], 200);
  }

  // Administrador ve cualquier perfil, usuario solo el suyo
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    // Si es usuario normal, solo puede ver su propio perfil
    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->usuario_id !== $id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este perfil'
        ], 403);
      }
    }

    $usuario = UsuarioInfo::find($id);

    if (!$usuario) {
      return response()->json([
        'mensaje' => 'Usuario no encontrado'
      ], 404);
    }

    return response()->json([
      'usuario' => $usuario
    ], 200);
  }

  // Administrador actualiza cualquier perfil, usuario solo el suyo
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    // Si es usuario normal, solo puede actualizar su propio perfil
    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->usuario_id !== $id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este perfil'
        ], 403);
      }
    }

    $usuario = UsuarioInfo::find($id);

    if (!$usuario) {
      return response()->json([
        'mensaje' => 'Usuario no encontrado'
      ], 404);
    }

    $validated = $request->validate([
      'nombre'           => 'sometimes|string|max:100',
      'apellidos'        => 'sometimes|string|max:100',
      'dni'              => 'sometimes|integer',
      'tipo_dni'         => 'sometimes|string|max:20',
      'direccion'        => 'sometimes|string|max:255',
      'pais'             => 'sometimes|string|max:100',
      'region'           => 'sometimes|string|max:100',
      'campo_aplicacion' => 'sometimes|string|max:100',
      'telefono'         => 'sometimes|string|max:20',
      'estado'           => 'sometimes|string|max:20',
    ]);

    $usuario->update($validated);

    return response()->json([
      'mensaje'  => 'Perfil actualizado exitosamente',
      'usuario'  => $usuario
    ], 200);
  }

  // Solo administrador puede eliminar perfiles
  public function destroy(int $id): JsonResponse
  {
    $usuario = UsuarioInfo::find($id);

    if (!$usuario) {
      return response()->json([
        'mensaje' => 'Usuario no encontrado'
      ], 404);
    }

    $usuario->delete();

    return response()->json([
      'mensaje' => 'Usuario eliminado exitosamente'
    ], 200);
  }
}
