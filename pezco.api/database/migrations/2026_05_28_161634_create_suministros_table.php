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
        Schema::create('suministros', function (Blueprint $table) {
            $table->id();
            $table->timestamp('fecha');
            $table->foreignId('insumo_id')
                ->constrained('insumos')
                ->onDelete('cascade');
            $table->foreignId('camada_id')
                ->constrained('camadas')
                ->onDelete('cascade');
            $table->decimal('cantidad', 10, 2);
            $table->string('unidad_metrica');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('suministros');
    }
};
