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
        Schema::create('estanques', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')
                ->constrained('usuarios')
                ->onDelete('cascade');
            $table->string('nombre');
            $table->decimal('m_frente', 8, 2);
            $table->decimal('m_fondo', 8, 2);
            $table->decimal('m_profundo', 8, 2);
            $table->decimal('m_cubicos', 10, 2);
            $table->integer('capacidad_alevin')->nullable();
            $table->integer('capacidad_juvenil')->nullable();
            $table->integer('capacidad_adulto')->nullable();
            $table->integer('capacidad_reproductor')->nullable();
            $table->string('tipo_estanque');
            $table->date('fecha_mantenimiento')->nullable();
            $table->date('fecha_vida_util')->nullable();
            $table->timestamp('fecha');
            $table->string('estado')->default('activo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('estanques');
    }
};
