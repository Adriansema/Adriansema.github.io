<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class Usuario extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;

  protected $table = 'datos_de_ingreso_usuario';

  protected $primaryKey = 'id';

  protected $fillable = [
    'usuario_id',
    'correo',
    'contrasena',
    'rol'
  ];

  protected $authPasswordName = 'contraseña';

  public function getEmailForPasswordReset(): string
  {
    return $this->correo;
  }

  public function getEmailForVerification(): string
  {
    return $this->correo;
  }

  protected $hidden = [
    'contraseña',
    'remember_token',
  ];

  protected $casts = [
    'usuario_id' => 'integer',
    'email_verified_at' => 'datetime',
    'contrasena' => 'hashed',
  ];

  public function usuario(): BelongsTo
  {
    return $this->belongsTo(UsuarioInfo::class, 'usuario_id');
  }
}
