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
            $table->foreignId('estanque_id')
                ->constrained('estanques')
                ->onDelete('cascade');
            $table->foreignId('especie_id')
                ->constrained('especies')
                ->onDelete('cascade');
            $table->timestamp('fecha_ingreso');
            $table->string('etapa')->default('alevin');
            $table->string('estado')->default('activa');
            $table->integer('cantidad_inicial');
            $table->integer('cantidad_muertes')->default(0);
            $table->integer('cantidad_salida')->default(0);
            $table->integer('cantidad_no_vendida')->default(0);
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
