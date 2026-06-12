<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Camada extends Model
{
    use HasFactory;

    protected $table = 'camadas';

    protected $primaryKey = 'id';

    protected $fillable = [
        'especie',
        'fecha_ingreso',
        'estado_ejemplares',
        'estanque_id',
        'biomasa_inicial',
        'densidad_poblacional',
        'precio_comercial'
    ];

    protected $casts = [
        'fecha_ingreso' => 'datetime',
        'biomasa_inicial' => 'decimal:2',
        'densidad_poblacional' => 'decimal:2',
        'precio_comercial' => 'decimal:2'
    ];
    
    public function suministro(): HasMany
    {
        return $this->hasMany(Suministro::class);
    }

    public function estanque(): BelongsTo
    {
        return $this->belongsTo(Estanque::class, 'estanque_id');
    }

    public function parametros(): HasMany
    {
        return $this->hasMany(Parametro::class, 'camada_id');
    }

    public function finanzas(): HasMany
    {
        return $this->hasMany(Finanza::class, 'camada_id');
    }
}
