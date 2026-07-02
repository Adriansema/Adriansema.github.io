<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use App\Models\UsuarioLicencia;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PagoController extends Controller
{
  // Solo administrador ve todos los pagos
  public function index(): JsonResponse
  {
    $pagos = Pago::with(['usuario', 'usuario_licencia.licencia'])->get();

    return response()->json([
      'pagos' => $pagos
    ], 200);
  }

  // Administrador ve cualquier pago, usuario solo los suyos
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $pago = Pago::with(['usuario', 'usuario_licencia.licencia'])->find($id);

    if (!$pago) {
      return response()->json([
        'mensaje' => 'Pago no encontrado'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'user') {
      if ($usuarioAutenticado->usuario_id !== $pago->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver este pago'
        ], 403);
      }
    }

    return response()->json([
      'pago' => $pago
    ], 200);
  }

  // El usuario registra un pago por su licencia
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    // El administrador no realiza pagos
    if ($usuarioAutenticado->rol === 'administrador') {
      return response()->json([
        'mensaje' => 'El administrador no realiza pagos de licencia'
      ], 403);
    }

    $validated = $request->validate([
      'usuario_licencia_id' => 'required|integer|exists:usuario_licencia,id',
      'metodo_pago'         => 'required|string|max:50',
      'monto'               => 'required|numeric|min:0',
      'moneda'              => 'required|string|max:10',
      'fecha_pago'          => 'required|date',
    ]);

    // Verificar que la licencia pertenece al usuario autenticado
    $usuarioLicencia = UsuarioLicencia::find($validated['usuario_licencia_id']);

    if ($usuarioAutenticado->usuario_id !== $usuarioLicencia->usuario_id) {
      return response()->json([
        'mensaje' => 'Esta licencia no te pertenece'
      ], 403);
    }

    $pago = Pago::create([
      'usuario_id'          => $usuarioAutenticado->usuario_id,
      'usuario_licencia_id' => $validated['usuario_licencia_id'],
      'metodo_pago'         => $validated['metodo_pago'],
      'monto'               => $validated['monto'],
      'moneda'              => $validated['moneda'],
      'estado'              => 'pendiente',
      'fecha_pago'          => $validated['fecha_pago'],
    ]);

    return response()->json([
      'mensaje' => 'Pago registrado exitosamente',
      'pago'    => $pago->load(['usuario_licencia.licencia'])
    ], 201);
  }

  // Solo administrador actualiza el estado del pago
  public function update(Request $request, int $id): JsonResponse
  {
    $pago = Pago::find($id);

    if (!$pago) {
      return response()->json([
        'mensaje' => 'Pago no encontrado'
      ], 404);
    }

    $validated = $request->validate([
      'estado' => 'required|string|in:pendiente,completado,rechazado',
    ]);

    $pago->update($validated);

    return response()->json([
      'mensaje' => 'Estado del pago actualizado exitosamente',
      'pago'    => $pago
    ], 200);
  }

  // Solo administrador puede eliminar pagos
  public function destroy(int $id): JsonResponse
  {
    $pago = Pago::find($id);

    if (!$pago) {
      return response()->json([
        'mensaje' => 'Pago no encontrado'
      ], 404);
    }

    $pago->delete();

    return response()->json([
      'mensaje' => 'Pago eliminado exitosamente'
    ], 200);
  }
}
