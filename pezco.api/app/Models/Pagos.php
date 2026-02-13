<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pagos extends Model
{
    use HasFactory;

    protected $table = 'pagos';

    protected $primaryKey = 'id';

    protected $fillable = [
        'usuario_id',
        'licencia_id',
        'usuario_licencia_id',
        'metodo_pago',
        'monto',
        'moneda',
        'estado',
        'fecha_pago'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'usuario_id' => 'integer',
        'licencia_id' => 'integer',
        'usuario_licencia_id' => 'integer',
        'monto' => 'decimal:2',
        'fecha_pago' => 'datetime',
    ];
}
