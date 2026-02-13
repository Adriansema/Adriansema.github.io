<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Suministros extends Model
{
    use HasFactory;

    protected $table = 'suministros';

    protected $primaryKey = 'id';

    protected $fillable = [
        'fecha',
        'insumo',
        'camada',
        'cantidad',
        'unidad_metrica'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'fecha' => 'datetime',
        'cantidad' => 'decimal:2'
    ];
}
