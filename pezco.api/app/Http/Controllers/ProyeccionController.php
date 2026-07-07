<?php

namespace App\Http\Controllers;

use App\Models\Camada;
use App\Models\Proyeccion;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProyeccionController extends Controller
{
    private const MAX_PROYECCIONES_ACTIVAS = 3;

    // Administrador ve todas, usuario ve solo las suyas
    public function index(Request $request): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $query = Proyeccion::with('detalles.especie');

        if ($usuarioAutenticado->rol === 'usuario') {
            $query->where('usuario_id', $usuarioAutenticado->usuario_id);
        }

        return response()->json([
            'proyecciones' => $query->get(),
        ], 200);
    }

    // Detalle completo de UNA proyección, con cumplimiento por especie
    public function show(Request $request, int $id): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $proyeccion = Proyeccion::with('detalles.especie')->find($id);

        if (!$proyeccion) {
            return response()->json(['mensaje' => 'Proyección no encontrada'], 404);
        }

        if ($usuarioAutenticado->rol === 'usuario'
            && $usuarioAutenticado->usuario_id !== $proyeccion->usuario_id) {
            return response()->json(['mensaje' => 'No tienes permisos para ver esta proyección'], 403);
        }

        $detallesConProgreso = $proyeccion->detalles->map(function ($detalle) use ($proyeccion) {
            return $this->calcularProgresoDetalle($detalle, $proyeccion);
        });

        return response()->json([
            'proyeccion' => $proyeccion,
            'detalles'   => $detallesConProgreso,
        ], 200);
    }

    // Resumen agregado para el Home: suma de TODAS las proyecciones vigentes
    public function resumenHome(Request $request): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $proyecciones = Proyeccion::with('detalles.especie')
            ->where('usuario_id', $usuarioAutenticado->usuario_id)
            ->vigentes()
            ->get();

        $metaTotal = 0;
        $ingresadoTotal = 0;

        foreach ($proyecciones as $proyeccion) {
            foreach ($proyeccion->detalles as $detalle) {
                $metaTotal += $detalle->cantidad_meta;
                $ingresadoTotal += $this->ingresadoPorDetalle($detalle, $proyeccion);
            }
        }

        return response()->json([
            'meta_total'          => $metaTotal,
            'ingresado_total'     => $ingresadoTotal,
            'porcentaje'          => $metaTotal > 0
                ? round(($ingresadoTotal / $metaTotal) * 100, 1)
                : 0,
            'proyecciones_activas' => $proyecciones->count(),
        ], 200);
    }

    public function store(Request $request): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $validated = $request->validate([
            'nombre'                    => 'nullable|string|max:255',
            'fecha_inicio'               => 'required|date',
            'fecha_fin'                  => 'required|date|after:fecha_inicio',
            'detalles'                   => 'required|array|min:1',
            'detalles.*.especie_id'      => 'required|integer|exists:especies,id',
            'detalles.*.cantidad_meta'   => 'required|integer|min:1',
        ]);

        // Regla de negocio: máximo 3 proyecciones activas por usuario
        $activasCount = Proyeccion::where('usuario_id', $usuarioAutenticado->usuario_id)
            ->where('estado', 'activa')
            ->count();

        if ($activasCount >= self::MAX_PROYECCIONES_ACTIVAS) {
            return response()->json([
                'mensaje' => 'Ya tienes el máximo de ' . self::MAX_PROYECCIONES_ACTIVAS . ' proyecciones activas permitidas',
            ], 422);
        }

        $proyeccion = Proyeccion::create([
            'usuario_id'   => $usuarioAutenticado->usuario_id,
            'nombre'       => $validated['nombre'] ?? null,
            'fecha_inicio' => $validated['fecha_inicio'],
            'fecha_fin'    => $validated['fecha_fin'],
            'estado'       => 'activa',
        ]);

        foreach ($validated['detalles'] as $detalle) {
            $proyeccion->detalles()->create($detalle);
        }

        return response()->json([
            'mensaje'    => 'Proyección creada exitosamente',
            'proyeccion' => $proyeccion->load('detalles.especie'),
        ], 201);
    }

    public function update(Request $request, int $id): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $proyeccion = Proyeccion::find($id);

        if (!$proyeccion) {
            return response()->json(['mensaje' => 'Proyección no encontrada'], 404);
        }

        if ($usuarioAutenticado->rol === 'usuario'
            && $usuarioAutenticado->usuario_id !== $proyeccion->usuario_id) {
            return response()->json(['mensaje' => 'No tienes permisos para modificar esta proyección'], 403);
        }

        $validated = $request->validate([
            'nombre'       => 'sometimes|string|max:255',
            'fecha_inicio' => 'sometimes|date',
            'fecha_fin'    => 'sometimes|date|after:fecha_inicio',
            'estado'       => 'sometimes|string|in:activa,finalizada,cancelada',
        ]);

        $proyeccion->update($validated);

        return response()->json([
            'mensaje'    => 'Proyección actualizada exitosamente',
            'proyeccion' => $proyeccion->load('detalles.especie'),
        ], 200);
    }

    public function destroy(Request $request, int $id): JsonResponse
    {
        $usuarioAutenticado = $request->user();

        $proyeccion = Proyeccion::find($id);

        if (!$proyeccion) {
            return response()->json(['mensaje' => 'Proyección no encontrada'], 404);
        }

        if ($usuarioAutenticado->rol === 'usuario'
            && $usuarioAutenticado->usuario_id !== $proyeccion->usuario_id) {
            return response()->json(['mensaje' => 'No tienes permisos para eliminar esta proyección'], 403);
        }

        $proyeccion->delete();

        return response()->json(['mensaje' => 'Proyección eliminada exitosamente'], 200);
    }

    // --- Helpers de cálculo ---

    private function camadasDelDetalle(\App\Models\ProyeccionDetalle $detalle, Proyeccion $proyeccion)
    {
        return Camada::where('especie_id', $detalle->especie_id)
            ->whereHas('estanque', function ($q) use ($proyeccion) {
                $q->where('usuario_id', $proyeccion->usuario_id);
            })
            ->whereDate('fecha_ingreso', '>=', $proyeccion->fecha_inicio)
            ->whereDate('fecha_ingreso', '<=', $proyeccion->fecha_fin)
            ->get();
    }

    private function ingresadoPorDetalle(\App\Models\ProyeccionDetalle $detalle, Proyeccion $proyeccion): int
    {
        return $this->camadasDelDetalle($detalle, $proyeccion)->sum('cantidad_inicial');
    }

    private function calcularProgresoDetalle(\App\Models\ProyeccionDetalle $detalle, Proyeccion $proyeccion): array
    {
        $camadas = $this->camadasDelDetalle($detalle, $proyeccion);

        $ingresado = $camadas->sum('cantidad_inicial');
        $terminado = $camadas->sum(function ($c) {
            return $c->cantidad_muertes + $c->cantidad_salida + $c->cantidad_no_vendida;
        });

        return [
            'especie_id'      => $detalle->especie_id,
            'especie_nombre'  => $detalle->especie->nombre ?? null,
            'cantidad_meta'   => $detalle->cantidad_meta,
            'ingresado'       => $ingresado,
            'terminado'       => $terminado,
            'meta_cumplida'   => $ingresado >= $detalle->cantidad_meta,
            'porcentaje'      => $detalle->cantidad_meta > 0
                ? round(($ingresado / $detalle->cantidad_meta) * 100, 1)
                : 0,
            'etapas_ingreso'  => $camadas->pluck('etapa')->countBy(),
        ];
    }
}