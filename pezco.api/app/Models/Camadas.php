<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Camadas extends Model
{
    use HasFactory;

    protected $table = 'camadas';

    protected $primaryKey = 'id';

    protected $fillable = [
        'especie',
        'fecha_ingreso',
        'estado_ejemplares',
        'estanque:id',
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
}
