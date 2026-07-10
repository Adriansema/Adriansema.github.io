import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';
import 'package:pezco_client/presentation/components/headComponent.dart';
import 'package:pezco_client/models/proyeccion_models.dart';
import 'package:pezco_client/services/proyecciones_service.dart';
import 'package:pezco_client/services/api_service.dart';

class Proyeccion extends StatefulWidget {
  const Proyeccion({super.key});

  @override
  State<Proyeccion> createState() => _ProyeccionState();
}

class _ProyeccionState extends State<Proyeccion> {
  bool _hoveredG = false;
  bool _hoveredT = false;

  late Future<ResumenProyeccion> _resumenFuture;

  @override
  void initState() {
    super.initState();
    _cargarResumen();
  }

  void _cargarResumen() {
    final servicio = context.read<ProyeccionesService>();
    _resumenFuture = servicio.obtenerResumenHome();
  }

  Future<void> _reintentar() async {
    setState(() => _cargarResumen());
    await _resumenFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: HeadComponent(
                title: "Proyección",
                action: true,
                iconMain: FontAwesomeIcons.solidFlag,
                iconGo: FontAwesomeIcons.angleRight,
                inclinacion: true,
                claro: true,
                letra: 0.4,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 8,
              child: FutureBuilder<ResumenProyeccion>(
                future: _resumenFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  if (snapshot.hasError) {
                    final esAuth = snapshot.error is UnauthorizedException;
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.white70, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            esAuth
                                ? 'Tu sesión expiró'
                                : 'No se pudo cargar la proyección',
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          if (!esAuth) ...[
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _reintentar,
                              child: const Text('Reintentar',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  final resumen = snapshot.data!;

                  if (resumen.sinDatos) {
                    return const Center(
                      child: Text(
                        'No tienes proyecciones vigentes',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return _buildContenido(resumen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContenido(ResumenProyeccion resumen) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 280),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _casillaValor(
                      maxWidth: maxWidth,
                      icon: FontAwesomeIcons.crosshairs,
                      valor: resumen.metaTotal,
                      hovered: _hoveredG,
                      onHover: (v) => setState(() => _hoveredG = v),
                    ),
                    const SizedBox(height: 10),
                    _casillaValor(
                      maxWidth: maxWidth,
                      icon: FontAwesomeIcons.listCheck,
                      valor: resumen.ingresadoTotal,
                      hovered: _hoveredT,
                      onHover: (v) => setState(() => _hoveredT = v),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: _graficoBarras(resumen),
          ),
        ],
      ),
    );
  }

  Widget _casillaValor({
    required double maxWidth,
    required IconData icon,
    required int valor,
    required bool hovered,
    required ValueChanged<bool> onHover,
  }) {
    return Container(
      width: maxWidth,
      height: maxWidth,
      constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
      decoration: const BoxDecoration(
        color: AppColors.backgroundElement,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child:
                          FaIcon(icon, color: const Color(0xFF000000), size: 18),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: HoverRegion(
                      onEnter: () => onHover(true),
                      onExit: () => onHover(false),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: hovered
                              ? AppColors.backgroundComponentSelected
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: hovered
                                ? const Color(0xFF000000)
                                : const Color(0x80000000),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$valor',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _graficoBarras(ResumenProyeccion resumen) {
    // Evitar división por cero y asegurar que la barra más alta llegue al tope
    final maxValor = resumen.metaTotal > resumen.ingresadoTotal
        ? resumen.metaTotal
        : resumen.ingresadoTotal;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundElement,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final alturaDisponible =
                constraints.maxHeight - 40; // espacio para labels

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _barra(
                  label: 'Meta',
                  valor: resumen.metaTotal,
                  alturaMax: alturaDisponible,
                  proporcion: maxValor > 0 ? resumen.metaTotal / maxValor : 0,
                  color: AppColors.primary.withValues(alpha: 0.4),
                ),
                _barra(
                  label: 'Ingresado',
                  valor: resumen.ingresadoTotal,
                  alturaMax: alturaDisponible,
                  proporcion:
                      maxValor > 0 ? resumen.ingresadoTotal / maxValor : 0,
                  color: AppColors.primary,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _barra({
    required String label,
    required int valor,
    required double alturaMax,
    required double proporcion,
    required Color color,
  }) {
    final altura = (alturaMax * proporcion).clamp(4.0, alturaMax);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$valor',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          width: 36,
          height: altura,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}