<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Especie extends Model
{
  use HasFactory;

  protected $table = 'especies';

  protected $primaryKey = 'id';

  protected $fillable = [
    'nombre',
    'nombre_cientifico',
    'descripcion',
    'dias_alevin',
    'dias_juvenil',
    'dias_adulto',
    'dias_reproductor',
    'peso_optimo_cosecha',
    'temperatura_min',
    'temperatura_max',
    'ph_min',
    'ph_max',
  ];

  protected $casts = [
    'id' => 'integer',
    'dias_alevin' => 'integer',
    'dias_juvenil' => 'integer',
    'dias_adulto' => 'integer',
    'dias_reproductor' => 'integer',
    'peso_optimo_cosecha' => 'decimal:2',
    'temperatura_min' => 'decimal:2',
    'temperatura_max' => 'decimal:2',
    'ph_min' => 'decimal:2',
    'ph_max' => 'decimal:2',
  ];

  public function camadas(): HasMany
  {
    return $this->hasMany(Camada::class);
  }
}
