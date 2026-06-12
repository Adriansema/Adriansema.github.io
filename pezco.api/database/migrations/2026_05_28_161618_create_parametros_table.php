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
        Schema::create('parametros', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camada_id')
                ->constrained('camadas')
                ->onDelete('cascade');
            $table->integer('n_medicion');
            $table->integer('muertes')->default(0);
            $table->decimal('peso_individual', 8, 2)->nullable();
            $table->decimal('peso_colectivo', 10, 2)->nullable();
            $table->decimal('temperatura', 5, 2)->nullable();
            $table->decimal('ph', 4, 2)->nullable();
            $table->decimal('alcalinidad', 8, 2)->nullable();
            $table->decimal('dureza', 8, 2)->nullable();
            $table->decimal('amonio', 8, 2)->nullable();
            $table->decimal('nitrito', 8, 2)->nullable();
            $table->decimal('nitrato', 8, 2)->nullable();
            $table->timestamp('fecha_medicion');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parametros');
    }
};
