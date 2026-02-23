<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

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

    public function finanzas(): HasMany
    {
        return $this->hasMany(Finanzas::class);
    }

    public function estanques(): HasMany
    {
        return $this->hasMany(Estanques::class);
    }

    public function insumos(): HasMany
    {
        return $this->hasMany(Insumos::class);
    }

    public function pagos(): HasMany
    {
        return $this->hasMany(Pagos::class);
    }

    public function licencia(): HasMany
    {
        return $this->hasMany(Usuario_licencia::class);
    }

    public function ingreso(): HasOne
    {
        return $this->hasOne(Datos_de_ingreso_usuario::class);
    }
}