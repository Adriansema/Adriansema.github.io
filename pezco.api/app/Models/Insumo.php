<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Insumo extends Model
{
    use HasFactory;

    protected $table = 'insumos';

    protected $primaryKey = 'id';

    protected $fillable = [
        'insumo',
        'cantidad',
        'unidad_metrica',
        'usuario_id',
        'fecha',
        'costo'
    ];

    protected $casts = [
        'cantidad' => 'decimal:2',
        'fecha' => 'datetime',
        'costo' => 'decimal:2'
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(UsuarioInfo::class, 'usuario_id');
    }

    public function suministro(): HasMany
    {
        return $this->hasMany(Suministro::class);
    }
}
