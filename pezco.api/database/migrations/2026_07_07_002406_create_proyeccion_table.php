<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('proyecciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')
                ->constrained('usuarios')
                ->onDelete('cascade');
            $table->string('nombre')->nullable();
            $table->date('fecha_inicio');
            $table->date('fecha_fin');
            $table->string('estado')->default('activa'); // activa, finalizada, cancelada
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('proyecciones');
    }
};
