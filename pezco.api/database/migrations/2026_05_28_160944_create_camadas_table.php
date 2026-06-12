<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('camadas', function (Blueprint $table) {
            $table->id();
            $table->string('especie');
            $table->timestamp('fecha_ingreso');
            $table->string('estado_ejemplares')->default('activa');
            $table->foreignId('estanque_id')
                ->constrained('estanques')
                ->onDelete('cascade');
            $table->decimal('biomasa_inicial', 10, 2)->nullable();
            $table->decimal('densidad_poblacional', 10, 2)->nullable();
            $table->decimal('precio_comercial', 10, 2)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('camadas');
    }
};
