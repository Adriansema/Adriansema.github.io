// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Excepción base para errores de la API
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Credenciales incorrectas o token inválido/expirado (401)
class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super(statusCode: 401);
}

/// Errores de validación del backend (422)
class ValidationException extends ApiException {
  final Map<String, dynamic> errors;
  ValidationException(super.message, this.errors) : super(statusCode: 422);
}

/// Sin conexión a internet o servidor no responde
class NetworkException extends ApiException {
  NetworkException(super.message);
}

class ApiService {
  // Ajusta esto según dónde corra tu servidor Laravel
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  String? _token;

  void setToken(String? token) {
    _token = token;
  }
  void Function()? onUnauthorized;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  Future<dynamic> get(String endpoint) => _request('GET', endpoint);

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) =>
      _request('POST', endpoint, body: body);

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) =>
      _request('PUT', endpoint, body: body);

  Future<dynamic> delete(String endpoint) => _request('DELETE', endpoint);

  Future<dynamic> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');

    try {
      late http.Response response;

      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: _headers)
              .timeout(const Duration(seconds: 10));
          break;
        case 'POST':
          response = await http
              .post(uri, headers: _headers, body: jsonEncode(body ?? {}))
              .timeout(const Duration(seconds: 10));
          break;
        case 'PUT':
          response = await http
              .put(uri, headers: _headers, body: jsonEncode(body ?? {}))
              .timeout(const Duration(seconds: 10));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: _headers)
              .timeout(const Duration(seconds: 10));
          break;
        default:
          throw ApiException('Método HTTP no soportado: $method');
      }

      return _handleResponse(response);
    } on http.ClientException {
      throw NetworkException(
          'No se pudo conectar con el servidor. Verifica tu conexión.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw NetworkException('Ocurrió un error inesperado: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    // Sin contenido (ej: logout exitoso)
    if (response.body.isEmpty) {
      if (statusCode >= 200 && statusCode < 300) return null;
      throw ApiException('Error del servidor', statusCode: statusCode);
    }

    final decoded = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return decoded;
    }

    final mensaje = decoded is Map
        ? (decoded['mensaje'] ?? decoded['message'] ?? 'Error desconocido')
        : 'Error desconocido';

    switch (statusCode) {
      case 401:
        onUnauthorized?.call();
        throw UnauthorizedException(mensaje);
      case 422:
        throw ValidationException(
          mensaje,
          decoded['errors'] ?? {},
        );
      default:
        throw ApiException(mensaje, statusCode: statusCode);
    }
  }
}