<?php

namespace App\Http\Controllers;

use App\Models\Camada;
use App\Models\Estanque;
use App\Models\Especie;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Carbon\Carbon;

class CamadasController extends Controller
{
  // Solo administrador ve todas las camadas
  public function index(): JsonResponse
  {
    $camadas = Camada::with(['estanque', 'especie'])->get();

    return response()->json([
      'camadas' => $camadas
    ], 200);
  }

  // Administrador ve cualquier camada, usuario solo las suyas
  public function show(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $camada = Camada::with(['estanque', 'especie'])->find($id);

    if (!$camada) {
      return response()->json([
        'mensaje' => 'Camada no encontrada'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para ver esta camada'
        ], 403);
      }
    }

    // Calcular etapa actual dinamicamente al consultar
    $etapaSugerida = $this->calcularEtapa($camada);

    return response()->json([
      'camada'        => $camada,
      'etapa_sugerida' => $etapaSugerida,
    ], 200);
  }

  // El usuario registra una camada en un estanque
  public function store(Request $request): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $validated = $request->validate([
      'estanque_id'      => 'required|integer|exists:estanques,id',
      'especie_id'       => 'required|integer|exists:especies,id',
      'fecha_ingreso'    => 'required|date',
      'cantidad_inicial' => 'required|integer|min:1',
      'precio_comercial' => 'nullable|numeric|min:0',
      'biomasa_inicial'  => 'nullable|numeric|min:0',
      // El usuario puede definir la etapa manualmente
      'etapa'            => 'nullable|string|in:alevin,juvenil,adulto,reproductor',
    ]);

    // Verificar que el estanque pertenece al usuario
    $estanque = Estanque::find($validated['estanque_id']);

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'Este estanque no te pertenece'
        ], 403);
      }
    }

    // Calcular densidad poblacional
    $densidad = $validated['cantidad_inicial'] / $estanque->m_cubicos;

    // La etapa inicial siempre es alevin salvo que el usuario indique otra
    $etapa = $validated['etapa'] ?? 'alevin';

    $camada = Camada::create([
      'estanque_id'          => $validated['estanque_id'],
      'especie_id'           => $validated['especie_id'],
      'fecha_ingreso'        => $validated['fecha_ingreso'],
      'etapa'                => $etapa,
      'estado'               => 'activa',
      'cantidad_inicial'     => $validated['cantidad_inicial'],
      'cantidad_muertes'     => 0,
      'cantidad_salida'      => 0,
      'cantidad_no_vendida'  => 0,
      'biomasa_inicial'      => $validated['biomasa_inicial'] ?? null,
      'densidad_poblacional' => round($densidad, 2),
      'precio_comercial'     => $validated['precio_comercial'] ?? null,
    ]);

    return response()->json([
      'mensaje' => 'Camada registrada exitosamente',
      'camada'  => $camada->load(['estanque', 'especie'])
    ], 201);
  }

  // Actualizar camada - traslado, bajas, precio, etapa manual
  public function update(Request $request, int $id): JsonResponse
  {
    $usuarioAutenticado = $request->user();

    $camada = Camada::with(['estanque', 'especie'])->find($id);

    if (!$camada) {
      return response()->json([
        'mensaje' => 'Camada no encontrada'
      ], 404);
    }

    if ($usuarioAutenticado->rol === 'usuario') {
      if ($usuarioAutenticado->usuario_id !== $camada->estanque->usuario_id) {
        return response()->json([
          'mensaje' => 'No tienes permisos para modificar esta camada'
        ], 403);
      }
    }

    $validated = $request->validate([
      // Traslado a otro estanque
      'estanque_id'         => 'sometimes|integer|exists:estanques,id',
      'cantidad_muertes'    => 'sometimes|integer|min:0',
      'cantidad_salida'     => 'sometimes|integer|min:0',
      'cantidad_no_vendida' => 'sometimes|integer|min:0',
      'precio_comercial'    => 'sometimes|numeric|min:0',
      'estado'              => 'sometimes|string|in:activa,trasladada,cosechada,cerrada',
      // El usuario puede corregir la etapa manualmente
      'etapa'               => 'sometimes|string|in:alevin,juvenil,adulto,reproductor',
    ]);

    // Si hay traslado, recalcular densidad con el nuevo estanque
    if (isset($validated['estanque_id'])) {
      $nuevoEstanque = Estanque::find($validated['estanque_id']);

      if ($usuarioAutenticado->rol === 'usuario') {
        if ($usuarioAutenticado->usuario_id !== $nuevoEstanque->usuario_id) {
          return response()->json([
            'mensaje' => 'El estanque destino no te pertenece'
          ], 403);
        }
      }

      $cantidadActual = $camada->cantidad_inicial
        - $camada->cantidad_muertes
        - $camada->cantidad_salida;

      $validated['densidad_poblacional'] = round(
        $cantidadActual / $nuevoEstanque->m_cubicos,
        2
      );
    }

    // Si el usuario no define etapa manualmente, calcularla automaticamente
    if (!isset($validated['etapa'])) {
      $validated['etapa'] = $this->calcularEtapa($camada);
    }

    $camada->update($validated);

    return response()->json([
      'mensaje' => 'Camada actualizada exitosamente',
      'camada'  => $camada
    ], 200);
  }

  // Solo administrador elimina camadas
  public function destroy(int $id): JsonResponse
  {
    $camada = Camada::find($id);

    if (!$camada) {
      return response()->json([
        'mensaje' => 'Camada no encontrada'
      ], 404);
    }

    $camada->delete();

    return response()->json([
      'mensaje' => 'Camada eliminada exitosamente'
    ], 200);
  }

  // Calcula la etapa actual segun tiempo transcurrido y peso
  private function calcularEtapa(Camada $camada): string
  {
    $especie      = $camada->especie;
    $diasIngreso  = Carbon::parse($camada->fecha_ingreso)->diffInDays(now());

    // Umbrales de tiempo por etapa segun la especie
    $umbralAlevin      = $especie->dias_alevin;
    $umbralJuvenil     = $umbralAlevin + $especie->dias_juvenil;
    $umbralAdulto      = $umbralJuvenil + $especie->dias_adulto;

    // Determinar etapa por tiempo
    if ($diasIngreso < $umbralAlevin) {
      $etapaPorTiempo = 'alevin';
    } elseif ($diasIngreso < $umbralJuvenil) {
      $etapaPorTiempo = 'juvenil';
    } elseif ($diasIngreso < $umbralAdulto) {
      $etapaPorTiempo = 'adulto';
    } else {
      $etapaPorTiempo = 'reproductor';
    }

    // Si hay parametros registrados, verificar el peso
    $ultimoParametro = $camada->parametros()->latest('fecha_medicion')->first();

    if ($ultimoParametro && $ultimoParametro->peso_individual) {
      $pesoActual  = $ultimoParametro->peso_individual;
      $pesoOptimo  = $especie->peso_optimo_cosecha;

      // Si el peso supera el 80% del optimo de cosecha, sugerir adulto
      if ($pesoActual >= ($pesoOptimo * 0.8)) {
        return 'adulto';
      }
    }

    return $etapaPorTiempo;
  }
}
