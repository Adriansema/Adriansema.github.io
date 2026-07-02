<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Finanza extends Model
{
  use HasFactory;

  protected $table = 'finanzas';

  protected $primaryKey = 'id';

  protected $fillable = [
    'usuario_id',
    'camada_id',
    'estanque_id',
    'fecha_emision',
    'ingresos_brutos',
    'costo_insumos',
    'perdidas',
    'rentabilidad_neta',
    'precio_comercial',
    'cantidad_vendida',
    'cantidad_muertes',
    'cantidad_no_vendida',
    'tipo_informe',
  ];

  protected $casts = [
    'usuario_id' => 'integer',
    'camada_id' => 'integer',
    'estanque_id' => 'integer',
    'fecha_emision' => 'datetime',
    'ingresos_brutos' => 'decimal:2',
    'costo_insumos' => 'decimal:2',
    'perdidas' => 'decimal:2',
    'rentabilidad_neta' => 'decimal:2',
    'precio_comercial' => 'decimal:2',
    'cantidad_vendida' => 'integer',
    'cantidad_muertes' => 'integer',
    'cantidad_no_vendida' => 'integer',
    'tipo_informe' => 'string',
  ];

  public function usuario(): BelongsTo
  {
    return $this->belongsTo(UsuarioInfo::class, 'usuario_id');
  }

  public function camada(): BelongsTo
  {
    return $this->belongsTo(Camada::class, 'camada_id');
  }

  public function estanque(): BelongsTo
  {
    return $this->belongsTo(Estanque::class, 'estanque_id');
  }
}
