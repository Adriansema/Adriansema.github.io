<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Suministros extends Model
{
    use HasFactory;

    protected $table = 'suministros';

    protected $primaryKey = 'id';

    protected $fillable = [
        'fecha',
        'insumo_id',
        'camada_id',
        'cantidad',
        'unidad_metrica'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'fecha' => 'datetime',
        'cantidad' => 'decimal:2'
    ];

    public function insumo(): BelongsTo
    {
        return $this->belongsTo(Insumos::class);
    }

    public function camada(): BelongsTo
    {
        return $this->belongsTo(Camadas::class);
    }
}
