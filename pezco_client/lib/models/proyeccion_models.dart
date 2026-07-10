class ResumenProyeccion {
  final int metaTotal;
  final int ingresadoTotal;
  final double porcentaje;
  final int proyeccionesActivas;

  ResumenProyeccion({
    required this.metaTotal,
    required this.ingresadoTotal,
    required this.porcentaje,
    required this.proyeccionesActivas,
  });

  factory ResumenProyeccion.fromJson(Map<String, dynamic> json) {
    return ResumenProyeccion(
      metaTotal: json['meta_total'] ?? 0,
      ingresadoTotal: json['ingresado_total'] ?? 0,
      porcentaje: (json['porcentaje'] ?? 0).toDouble(),
      proyeccionesActivas: json['proyecciones_activas'] ?? 0,
    );
  }

  bool get sinDatos => proyeccionesActivas == 0;
}