// lib/services/proyecciones_service.dart
import '../models/proyeccion_models.dart';
import 'api_service.dart';

class ProyeccionesService {
  final ApiService _apiService;

  ProyeccionesService(this._apiService);

  Future<ResumenProyeccion> obtenerResumenHome() async {
    final response = await _apiService.get('proyecciones/resumen-home');
    return ResumenProyeccion.fromJson(response);
  }
}