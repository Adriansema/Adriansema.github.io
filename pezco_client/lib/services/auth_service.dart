// lib/services/auth_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_service.dart';

class Usuario {
  final int id;
  final String nombre;
  final String apellidos;
  final String campoAplicacion;
  final String estado;

  Usuario({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.campoAplicacion,
    required this.estado,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        nombre: json['nombre'],
        apellidos: json['apellidos'],
        campoAplicacion: json['campo_aplicacion'],
        estado: json['estado'],
      );
}

class AuthService {
  final ApiService _apiService;
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';

  AuthService(this._apiService);

  Future<Usuario> login(String correo, String contrasena) async {
    final response = await _apiService.post('auth/login', body: {
      'correo': correo,
      'contrasena': contrasena,
    });

    final token = response['token'] as String;
    final usuario = Usuario.fromJson(response['usuario']);

    await _storage.write(key: _tokenKey, value: token);
    _apiService.setToken(token);

    return usuario;
  }

  Future<void> logout() async {
    try {
      await _apiService.post('auth/logout');
    } catch (_) {
      // Si falla la llamada al backend, igual limpiamos localmente
    } finally {
      await _storage.delete(key: _tokenKey);
      _apiService.setToken(null);
    }
  }

  /// Intenta restaurar el token guardado al abrir la app
  Future<String?> getStoredToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      _apiService.setToken(token);
    }
    return token;
  }
}