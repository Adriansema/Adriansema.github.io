<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class UsuarioInfo extends Model
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

  protected $hidden = [
    'dni',
    'tipo_dni',
    'direccion',
    'pais',
    'region',
    'telefono'
  ];

  protected $casts = [
    'dni' => 'integer',
    'fecha_registro' => 'datetime',
    'fecha_actualizacion' => 'datetime',
  ];

  public function finanzas(): HasMany
  {
    return $this->hasMany(Finanza::class);
  }

  public function estanques(): HasMany
  {
    return $this->hasMany(Estanque::class);
  }

  public function insumos(): HasMany
  {
    return $this->hasMany(Insumo::class);
  }

  public function pagos(): HasMany
  {
    return $this->hasMany(Pago::class);
  }

  public function licencia(): HasMany
  {
    return $this->hasMany(UsuarioLicencia::class);
  }

  public function ingreso(): HasOne
  {
    return $this->hasOne(Usuario::class, 'usuario_id');
  }
}
