<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;

class RegistroRequest extends FormRequest
{
  /**
   * Determine if the user is authorized to make this request.
   */
  public function authorize(): bool
  {
    return true;
  }

  /**
   * Get the validation rules that apply to the request.
   *
   * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
   */
  public function rules(): array
  {
    return [
      // Datos de UsuariosInfo
      'nombre'           => 'required|string|max:100',
      'apellidos'        => 'required|string|max:100',
      'dni'              => 'required|integer',
      'tipo_dni'         => 'required|string|max:20',
      'direccion'        => 'required|string|max:255',
      'pais'             => 'required|string|max:100',
      'region'           => 'required|string|max:100',
      'campo_aplicacion' => 'required|string|max:100',
      'telefono'         => 'required|string|max:20',

      // Datos de User
      'correo'           => 'required|email|unique:datos_de_ingreso_usuario,correo',
      'contrasena'       => 'required|string|min:8|confirmed',
    ];
  }
}
