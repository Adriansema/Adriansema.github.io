<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Licencia extends Model
{
    use HasFactory;

    protected $table = 'licencia';

    protected $primaryKey = 'id';

    protected $fillable = [
        'nombre',
        'tipo',
        'descripcion',
        'estanques',
        'soporte',
        'duracion_mes',
        'precio_mes',
        'precio_anual',
        'tipo_cambio'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'estanques' => 'integer',
        'duracion_mes' => 'integer',
        'precio_mes' => 'decimal:2',
        'precio_anual' => 'decimal:2'
    ];
}
