<?php

namespace App\Http\Controllers;

use App\Models\Usuario;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UsuarioController extends Controller
{
  // Solo administrador puede ver todos los registros de acceso
  public function index(): JsonResponse
  {
    $users = Usuario::all();

    return response()->json([
      'users' => $users
    ], 200);
  }

  // Administrador ve cualquier registro, usuario solo el suyo
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->id !== $id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este registro'
        ], 403);
      }
    }

    $user = Usuario::find($id);

    if (!$user) {
      return response()->json([
        'mensaje' => 'Registro no encontrado'
      ], 404);
    }

    return response()->json([
      'user' => $user
    ], 200);
  }

  // Administrador actualiza cualquier registro, usuario solo el suyo
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->id !== $id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar este registro'
        ], 403);
      }
    }

    $user = Usuario::find($id);

    if (!$user) {
      return response()->json([
        'mensaje' => 'Registro no encontrado'
      ], 404);
    }

    $validated = $request->validate([
      'correo'     => 'sometimes|email|unique:datos_de_ingreso_usuario,correo,' . $id,
      'contrasena' => 'sometimes|string|min:8|confirmed',
      // Solo el administrador puede cambiar roles
      'rol'        => 'sometimes|string|in:user,supervisor,administrador',
    ]);

    // Si viene nueva contraseña, hashearla manualmente
    if (isset($validated['contrasena'])) {
      $validated['contrasena'] = Hash::make($validated['contrasena']);
    }

    // Evitar que un usuario normal cambie su propio rol
    if ($usuarioAutenticado->rol === 'user' && isset($validated['rol'])) {
      unset($validated['rol']);
    }

    $user->update($validated);

    return response()->json([
      'mensaje' => 'Registro actualizado exitosamente',
      'user'    => $user
    ], 200);
  }

  // Solo administrador puede eliminar registros de acceso
  public function destroy(int $id): JsonResponse
  {
    $user = Usuario::find($id);

    if (!$user) {
      return response()->json([
        'mensaje' => 'Registro no encontrado'
      ], 404);
    }

    $user->delete();

    return response()->json([
      'mensaje' => 'Registro eliminado exitosamente'
    ], 200);
  }
}
