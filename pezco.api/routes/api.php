<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\LicenciaController;

// Rutas públicas (no requieren token)
Route::prefix('auth')->group(function () {
    Route::post('/registro', [AuthController::class, 'registro']);
    Route::post('/login',    [AuthController::class, 'login']);
});

// Rutas protegidas (requieren token)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/licencias',          [LicenciaController::class, 'index']);
    Route::get('/licencias/{id}',     [LicenciaController::class, 'show']);

    // Solo administrador
    Route::middleware('rol:administrador')->group(function () {
        Route::post('/licencias',         [LicenciaController::class, 'store']);
        Route::put('/licencias/{id}',     [LicenciaController::class, 'update']);
        Route::delete('/licencias/{id}', [LicenciaController::class, 'destroy']);
    });
    Route::post('/auth/logout', [AuthController::class, 'logout']);
});