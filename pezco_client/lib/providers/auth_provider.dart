// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

enum AuthStatus { desconocido, autenticado, noAutenticado }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  AuthStatus _status = AuthStatus.desconocido;
  Usuario? _usuario;
  String? _errorMensaje;
  bool _isLoading = false;

  AuthStatus get status => _status;
  Usuario? get usuario => _usuario;
  String? get errorMensaje => _errorMensaje;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.autenticado;

  /// Se llama una vez al arrancar la app, para ver si hay un token guardado.
  /// Como no hay endpoint de validación, solo confiamos en que exista el token.
  /// Si en algún momento el token es inválido, la primera petición a la API
  /// devolverá 401 y desde ahí forzamos logout.
  Future<void> intentarRestaurarSesion() async {
    final token = await _authService.getStoredToken();
    _status = token != null ? AuthStatus.autenticado : AuthStatus.noAutenticado;
    notifyListeners();
  }

  Future<bool> login(String correo, String contrasena) async {
    _isLoading = true;
    _errorMensaje = null;
    notifyListeners();

    try {
      final usuario = await _authService.login(correo, contrasena);
      _usuario = usuario;
      _status = AuthStatus.autenticado;
      return true;
    } on UnauthorizedException {
      _errorMensaje = 'Correo o contraseña incorrectos.';
      _status = AuthStatus.noAutenticado;
      return false;
    } on ValidationException catch (e) {
      _errorMensaje = e.message;
      _status = AuthStatus.noAutenticado;
      return false;
    } on NetworkException catch (e) {
      _errorMensaje = e.message;
      _status = AuthStatus.noAutenticado;
      return false;
    } catch (e) {
      _errorMensaje = 'Ocurrió un error inesperado. Intenta de nuevo.';
      _status = AuthStatus.noAutenticado;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authService.logout();

    _usuario = null;
    _status = AuthStatus.noAutenticado;
    _isLoading = false;
    notifyListeners();
  }

  /// Se llama desde ApiService cuando cualquier petición devuelve 401
  /// (token expirado/inválido), para forzar logout sin llamar al backend de nuevo.
  void forzarCierreSesionPorTokenInvalido() {
    _usuario = null;
    _status = AuthStatus.noAutenticado;
    _errorMensaje = 'Tu sesión expiró. Por favor inicia sesión de nuevo.';
    notifyListeners();
  }
}