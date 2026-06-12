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
        'fecha_emision',
        'precio_esperado',
        'precio_final'
    ];

    protected $casts = [
        'usuario_id' => 'integer',
        'camada_id' => 'integer',
        'fecha_emision' => 'datetime',
        'precio_esperado' => 'decimal:2',
        'precio_final' => 'decimal:2'
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(UsuarioInfo::class, 'usuario_id');
    }

    public function camada(): BelongsTo
    {
        return $this->belongsTo(Camada::class, 'camada_id');
    }
}
