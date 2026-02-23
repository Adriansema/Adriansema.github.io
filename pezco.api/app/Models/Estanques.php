<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Estanques extends Model
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
        'capacidad_ejemplares',
        'fecha',
        'estado',
        'tipo_estanque'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'usuario_id' => 'integer',
        'm_frente' => 'decimal:2',
        'm_fondo' => 'decimal:2',
        'm_profundo' => 'decimal:2',
        'm_cubicos' => 'decimal:2',
        'capacidad_ejemplares' => 'integer',
        'fecha' => 'datetime',
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(Usuarios::class);
    }

    public function camadas(): BelongsTo
    {
        return $this->belongsTo(Camadas::class);
    }
}
