<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Insumos extends Model
{
    use HasFactory;

    protected $table = 'insumos';

    protected $primaryKey = 'id';

    protected $fillable = [
        'insumo',
        'cantidad',
        'unidad_metrica',
        'usuario',
        'fecha',
        'costo'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'cantidad' => 'decimal:2',
        'fecha' => 'datetime',
        'costo' => 'decimal:2'
    ];
}
