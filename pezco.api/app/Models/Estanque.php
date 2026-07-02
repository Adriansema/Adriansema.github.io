<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Estanque extends Model
{
  use HasFactory;

  protected $table = 'estanques';

  protected $primaryKey = 'id';

  protected $fillable = [
    'usuario_id',
    'nombre',
    'm_frente',
    'm_fondo',
    'm_profundo',
    'm_cubicos',
    'capacidad_alevin',
    'capacidad_juvenil',
    'capacidad_adulto',
    'capacidad_reproductor',
    'fecha_mantenimiento',
    'fecha_vida_util',
    'fecha',
    'estado',
    'tipo_estanque'
  ];

  protected $casts = [
    'usuario_id' => 'integer',
    'm_frente' => 'decimal:2',
    'm_fondo' => 'decimal:2',
    'm_profundo' => 'decimal:2',
    'm_cubicos' => 'decimal:2',
    'capacidad_alevin' => 'integer',
    'capacidad_juvenil' => 'integer',
    'capacidad_adulto' => 'integer',
    'capacidad_reproductor' => 'integer',
    'fecha_mantenimiento' => 'date',
    'fecha_vida_util' => 'date',
    'fecha' => 'datetime',
  ];

  public function usuario(): BelongsTo
  {
    return $this->belongsTo(UsuarioInfo::class, 'usuario_id');
  }

  public function camadas(): HasMany
  {
    return $this->hasMany(Camada::class);
  }

  public function camadaActiva(): BelongsTo
  {
    return $this->hasOne(Camada::class)->where('estado', 'activa')->latest();
  }
}
