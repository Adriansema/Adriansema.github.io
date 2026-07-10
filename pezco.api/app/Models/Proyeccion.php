<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Proyeccion extends Model
{
  use HasFactory;

  protected $table = 'proyecciones';

  protected $fillable = [
    'usuario_id',
    'nombre',
    'fecha_inicio',
    'fecha_fin',
    'estado',
  ];

  protected $casts = [
    'fecha_inicio' => 'date',
    'fecha_fin'    => 'date',
  ];

  public function usuario(): BelongsTo
  {
    return $this->belongsTo(Usuario::class, 'usuario_id');
  }

  public function detalles(): HasMany
  {
    return $this->hasMany(ProyeccionDetalle::class, 'proyeccion_id');
  }

  // Vigente = activa y la fecha de hoy cae dentro del rango
  public function scopeVigentes($query)
  {
    $hoy = now()->toDateString();
    return $query->where('estado', 'activa')
      ->where('fecha_inicio', '<=', $hoy)
      ->where('fecha_fin', '>=', $hoy);
  }
}
