<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\LicenciaController;
use App\Http\Controllers\UsuarioInfoController;
use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\UsuarioLicenciaController;
use App\Http\Controllers\PagoController;
use App\Http\Controllers\EstanquesController;
use App\Http\Controllers\CamadasController;
use App\Http\Controllers\ParametrosController;
use App\Http\Controllers\InsumosController;
use App\Http\Controllers\SuministrosController;
use App\Http\Controllers\FinanzasController;
use App\Http\Controllers\EspeciesController;
use App\Http\Controllers\ProyeccionController;
//apiResource
Route::prefix('auth')->group(function () {
  Route::post('/registro', [AuthController::class, 'registro']);
  Route::post('/login',    [AuthController::class, 'login']);
});

Route::middleware('auth:sanctum')->group(function () {
  Route::get('proyecciones/resumen-home', [ProyeccionController::class, 'resumenHome']);
  Route::apiResource('proyecciones', ProyeccionController::class);

  Route::get('/especies',      [EspeciesController::class, 'index']);
  Route::get('/especies/{id}', [EspeciesController::class, 'show']);

  Route::middleware('rol:administrador')->group(function () {
    Route::post('/especies',         [EspeciesController::class, 'store']);
    Route::put('/especies/{id}',     [EspeciesController::class, 'update']);
    Route::delete('/especies/{id}',  [EspeciesController::class, 'destroy']);
  });

  Route::get('/finanzas', [FinanzasController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/finanzas/{id}',    [FinanzasController::class, 'show']);
  Route::post('/finanzas',        [FinanzasController::class, 'store']);

  Route::delete('/finanzas/{id}', [FinanzasController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/suministros', [SuministrosController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/suministros/{id}',    [SuministrosController::class, 'show']);
  Route::post('/suministros',        [SuministrosController::class, 'store']);
  Route::put('/suministros/{id}',    [SuministrosController::class, 'update']);

  Route::delete('/suministros/{id}', [SuministrosController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/insumos', [InsumosController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/insumos/{id}',    [InsumosController::class, 'show']);
  Route::post('/insumos',        [InsumosController::class, 'store']);
  Route::put('/insumos/{id}',    [InsumosController::class, 'update']);

  Route::delete('/insumos/{id}', [InsumosController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/parametros', [ParametrosController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/parametros/{id}',    [ParametrosController::class, 'show']);
  Route::post('/parametros',        [ParametrosController::class, 'store']);
  Route::put('/parametros/{id}',    [ParametrosController::class, 'update']);

  Route::delete('/parametros/{id}', [ParametrosController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/camadas', [CamadasController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/camadas/{id}',    [CamadasController::class, 'show']);
  Route::post('/camadas',        [CamadasController::class, 'store']);
  Route::put('/camadas/{id}',    [CamadasController::class, 'update']);

  Route::delete('/camadas/{id}', [CamadasController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/estanques', [EstanquesController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/estanques/{id}',    [EstanquesController::class, 'show']);
  Route::post('/estanques',        [EstanquesController::class, 'store']);
  Route::put('/estanques/{id}',    [EstanquesController::class, 'update']);

  Route::delete('/estanques/{id}', [EstanquesController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/licencias',          [LicenciaController::class, 'index']);
  Route::get('/licencias/{id}',     [LicenciaController::class, 'show']);

  Route::middleware('rol:administrador')->group(function () {
    Route::post('/licencias',         [LicenciaController::class, 'store']);
    Route::put('/licencias/{id}',     [LicenciaController::class, 'update']);
    Route::delete('/licencias/{id}', [LicenciaController::class, 'destroy']);
  });
  Route::post('/auth/logout', [AuthController::class, 'logout']);

  Route::get('/usuarios', [UsuarioInfoController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/usuarios/{id}',    [UsuarioInfoController::class, 'show']);
  Route::put('/usuarios/{id}',    [UsuarioInfoController::class, 'update']);

  Route::delete('/usuarios/{id}', [UsuarioInfoController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/users', [UsuarioController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/users/{id}',    [UsuarioController::class, 'show']);
  Route::put('/users/{id}',    [UsuarioController::class, 'update']);

  Route::delete('/users/{id}', [UsuarioController::class, 'destroy'])
    ->middleware('rol:administrador');

  Route::get('/usuario-licencias', [UsuarioLicenciaController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/usuario-licencias/{id}', [UsuarioLicenciaController::class, 'show']);

  Route::post('/usuario-licencias', [UsuarioLicenciaController::class, 'store']);

  Route::middleware('rol:administrador')->group(function () {
    Route::put('/usuario-licencias/{id}',    [UsuarioLicenciaController::class, 'update']);
    Route::delete('/usuario-licencias/{id}', [UsuarioLicenciaController::class, 'destroy']);
  });

  Route::get('/pagos', [PagoController::class, 'index'])
    ->middleware('rol:administrador');

  Route::get('/pagos/{id}', [PagoController::class, 'show']);

  Route::post('/pagos', [PagoController::class, 'store']);

  Route::middleware('rol:administrador')->group(function () {
    Route::put('/pagos/{id}',    [PagoController::class, 'update']);
    Route::delete('/pagos/{id}', [PagoController::class, 'destroy']);
  });
});
