<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuarios extends Model
{
    use HasFactory;

    protected $table = 'usuarios';

    protected $primaryKey = 'id';

    public $timestamps = true;

    const CREATED_AT = 'fecha_registro';
    const UPDATED_AT = 'fecha_actualizacion';

    protected $fillable = [
        'nombre',
        'apellidos',
        'dni',
        'tipo_dni',
        'direccion',
        'pais',
        'region',
        'campo_aplicacion',
        'telefono',
        'estado'
    ];

    protected $guarded = ['id'];

    protected $hidden = [
        'dni',
        'tipo_dni',
        'direccion',
        'pais',
        'region',
        'telefono'
    ];

    protected $casts = [
        'id' => 'integer',
        'dni' => 'integer',
        'fecha_registro' => 'datetime',
        'fecha_actualizacion' => 'datetime',
    ];
}