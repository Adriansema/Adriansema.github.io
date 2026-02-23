<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Camadas extends Model
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

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'fecha_ingreso' => 'datetime',
        'biomasa_inicial' => 'decimal:2',
        'densidad_poblacional' => 'decimal:2',
        'precio_comercial' => 'decimal:2'
    ];
    
    public function suministro(): HasMany
    {
        return $this->hasMany(Suministros::class);
    }

    public function estanque(): HasOne
    {
        return $this->hasOne(Estanques::class);
    }

    public function parametros(): BelongsTo
    {
        return $this->belongsTo(Parametros::class);
    }

    public function finanza(): BelongsTo
    {
        return $this->belongsTo(Finanzas::class);
    }
}
