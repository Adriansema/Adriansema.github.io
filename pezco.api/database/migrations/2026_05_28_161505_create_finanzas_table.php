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
        Schema::create('finanzas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')
                ->constrained('usuarios')
                ->onDelete('cascade');
            $table->foreignId('camada_id')
                ->constrained('camadas')
                ->onDelete('cascade');
            $table->foreignId('estanque_id')
                ->constrained('estanques')
                ->onDelete('cascade');
            $table->timestamp('fecha_emision');
            $table->decimal('ingresos_brutos', 12, 2)->default(0);
            $table->decimal('costo_insumos', 12, 2)->default(0);
            $table->decimal('perdidas', 12, 2)->default(0);
            $table->decimal('rentabilidad_neta', 12, 2)->default(0);
            $table->decimal('precio_comercial', 12, 2)->default(0);
            $table->integer('cantidad_vendida')->default(0);
            $table->integer('cantidad_muertes')->default(0);
            $table->integer('cantidad_no_vendida')->default(0);
            $table->string('tipo_informe')->default('general');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('finanzas');
    }
};
