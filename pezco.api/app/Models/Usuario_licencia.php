<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Usuario_licencia extends Model
{
    use HasFactory;

    protected $table = 'usuario_licencia';

    protected $primaryKey = 'id';

    protected $fillable = [
        'usuario_id',
        'licencia_id',
        'fecha_emision',
        'fecha_expiracion',
        'estado'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'usuario_id' => 'integer',
        'licencia_id' => 'integer',
        'fecha_emision' => 'datetime',
        'fecha_expiracion' => 'datetime',
    ];

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(Usuarios::class);
    }

    public function licencia(): BelongsTo
    {
        return $this->belongsTo(Licencia::class);
    }

    public function pagos(): HasMany
    {
        return $this->hasMany(Pagos::class);
    }
}
