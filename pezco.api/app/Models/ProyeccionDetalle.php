<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProyeccionDetalle extends Model
{
    use HasFactory;

    protected $table = 'proyeccion_detalles';

    protected $fillable = [
        'proyeccion_id',
        'especie_id',
        'cantidad_meta',
    ];

    protected $casts = [
        'cantidad_meta' => 'integer',
    ];

    public function proyeccion(): BelongsTo
    {
        return $this->belongsTo(Proyeccion::class, 'proyeccion_id');
    }

    public function especie(): BelongsTo
    {
        return $this->belongsTo(Especie::class, 'especie_id');
    }
}
