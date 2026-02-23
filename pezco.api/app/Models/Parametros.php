<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Parametros extends Model
{
    use HasFactory;

    protected $table = 'parametros';

    protected $primaryKey = 'id';

    protected $fillable = [
        'camada_id',
        'n_medicion',
        'muertes',
        'peso_individual',
        'peso_colectivo',
        'temperatura',
        'ph',
        'alcalinidad',
        'dureza',
        'amonio',
        'nitrito',
        'nitrato',
        'fecha_medicion'
    ];

    protected $guarded = ['id'];

    protected $casts = [
        'id' => 'integer',
        'camada_id' => 'integer',
        'n_medicion' => 'integer',
        'muertes' => 'integer',
        'peso_individual' => 'decimal:2',
        'peso_colectivo' => 'decimal:2',
        'temperatura' => 'decimal:2',
        'ph' => 'decimal:2',
        'alcalinidad' => 'decimal:2',
        'dureza' => 'decimal:2',
        'amonio' => 'decimal:2',
        'nitrito' => 'decimal:2',
        'nitrato' => 'decimal:2',
        'fecha_medicion' => 'datetime'
    ];

    public function camada()
    {
        return $this->belongsTo(Camadas::class);
    }
}
