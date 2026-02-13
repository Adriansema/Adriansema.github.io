<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Datos_de_ingreso_usuario extends Model
{
    use HasFactory;

    protected $table = 'datos_de_ingreso_usuario';

    protected $primaryKey = 'id';

    protected $fillable = [
        'usuario_id',
        'correo',
        'contrasena',
    ];

    protected $guarded = ['id'];

    protected $hidden = [
        'contrasena',
    ];

    protected $casts = [
        'id' => 'integer',
        'usuario_id' => 'integer',
    ];
}
