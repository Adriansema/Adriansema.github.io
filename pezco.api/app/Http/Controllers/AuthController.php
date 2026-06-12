<?php

namespace App\Http\Controllers;

use App\Http\Requests\Auth\LoginRequest;
use App\Http\Requests\Auth\RegistroRequest;
use App\Models\User;
use App\Models\Usuario;
use App\Models\UsuarioInfo;
use App\Models\UsuariosInfo;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function registro(RegistroRequest $request): JsonResponse
    {
        // 1. Crear el perfil del usuario
        $usuarioInfo = UsuarioInfo::create([
            'nombre'           => $request->nombre,
            'apellidos'        => $request->apellidos,
            'dni'              => $request->dni,
            'tipo_dni'         => $request->tipo_dni,
            'direccion'        => $request->direccion,
            'pais'             => $request->pais,
            'region'           => $request->region,
            'campo_aplicacion' => $request->campo_aplicacion,
            'telefono'         => $request->telefono,
            'estado'           => 'activo'
        ]);

        // 2. Crear las credenciales de acceso vinculadas al perfil
        $user = Usuario::create([
            'usuario_id' => $usuarioInfo->id,
            'correo'     => $request->correo,
            'contrasena' => $request->contrasena,
            'rol'        => 'user'
        ]);

        // 3. Generar el token de acceso
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'mensaje' => 'Usuario registrado exitosamente',
            'token'   => $token,
            'usuario' => $usuarioInfo,
        ], 201);
    }

    public function login(LoginRequest $request): JsonResponse
    {
        // 1. Buscar el usuario por correo
        $user = Usuario::where('correo', $request->correo)->first();

        // 2. Verificar que existe y que la contraseña es correcta
        if (!$user || !Hash::check($request->contrasena, $user->contrasena)) {
            return response()->json([
                'mensaje' => 'Credenciales incorrectas'
            ], 401);
        }

        // 3. Eliminar tokens anteriores (sesión única)
        $user->tokens()->delete();

        // 4. Generar nuevo token
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'mensaje' => 'Login exitoso',
            'token'   => $token,
            'usuario' => $user->usuario,
        ], 200);
    }

    public function logout(Request $request): JsonResponse
    {
        // Elimina solo el token con el que se hizo esta petición
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'mensaje' => 'Sesión cerrada exitosamente'
        ], 200);
    }
}