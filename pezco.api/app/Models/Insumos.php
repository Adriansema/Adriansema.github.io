<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Insumos extends Model
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

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'cantidad' => 'decimal:2',
        'fecha' => 'datetime',
        'costo' => 'decimal:2'
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(Usuarios::class);
    }

    public function suministro(): HasMany
    {
        return $this->hasMany(Suministros::class);
    }
}
