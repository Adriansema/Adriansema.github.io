<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('proyeccion_detalles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('proyeccion_id')
                ->constrained('proyecciones')
                ->onDelete('cascade');
            $table->foreignId('especie_id')
                ->constrained('especies')
                ->onDelete('cascade');
            $table->integer('cantidad_meta');
            $table->timestamps();

            // No repetir la misma especie 2 veces dentro de la misma proyección
            $table->unique(['proyeccion_id', 'especie_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('proyeccion_detalles');
    }
};
