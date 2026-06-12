<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class VerificarRol
{
    public function handle(Request $request, Closure $next, string ...$roles): Response
    {
        if (!$request->user()) {
            return response()->json([
                'mensaje' => 'No autenticado'
            ], 401);
        }

        if (!in_array($request->user()->rol, $roles)) {
            return response()->json([
                'mensaje' => 'No tienes permisos para realizar esta acción'
            ], 403);
        }

        return $next($request);
    }
}
