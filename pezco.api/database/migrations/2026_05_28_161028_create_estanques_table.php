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
            $table->integer('capacidad_ejemplares');
            $table->timestamp('fecha');
            $table->string('estado')->default('activo');
            $table->string('tipo_estanque')->nullable();
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
