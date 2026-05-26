import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/headComponent.dart';

class Diversidad extends StatefulWidget {
  const Diversidad({super.key});

  @override
  State<Diversidad> createState() => _DiversidadState();
}

class _DiversidadState extends State<Diversidad> {
  @override
  Widget build(BuildContext context) {
    final segments = [
      (20, const Color(0xFF4FC3D0), 'Tilápia'),
      (30, const Color(0xFF3A6FD8), 'Cachama'),
      (50, const Color(0xFF2A3FA0), 'Trucha'),
    ];
    final isCompact = ResponsiveSize.isCompactDevice(context);

    if (isCompact) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: double.infinity,
                width: 140,
                child: HeadComponent(
                  title: "Diversidad",
                  action: false,
                  iconMain: FontAwesomeIcons.fish,
                  iconGo: FontAwesomeIcons.angleRight,
                  inclinacion: true,
                  letra: 0.25,
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: segments.map((seg) {
                            final (percent, _, label) = seg;
                            return Expanded(
                              flex: percent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Texto
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$percent%',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        label,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          color: Colors.transparent,
                          height: 10,
                          child: ClipRRect(
                            child: Row(
                              children: segments.map((seg) {
                                final (percent, color, _) = seg;
                                return Expanded(
                                  flex: percent,
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: 60,
                    child: HeadComponent(
                      title: "Diversidad",
                      action: false,
                      iconMain: FontAwesomeIcons.fish,
                      iconGo: FontAwesomeIcons.angleRight,
                      inclinacion: true,
                      letra: 0.4,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: maxWidth * 0.4,
                              constraints: BoxConstraints(maxWidth: 120),
                              child: ClipRRect(
                                child: Column(
                                  children: segments.map((seg) {
                                    final (percent, color, _) = seg;
                                    return Expanded(
                                      flex: percent,
                                      child: Container(
                                        foregroundDecoration: BoxDecoration(
                                          color: color,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: segments.map((seg) {
                                final (percent, _, label) = seg;
                                return Expanded(
                                  flex: percent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomPaint(
                                        size: const Size(14, double.infinity),
                                        painter: _BracketPainter(),
                                      ),
                                      const SizedBox(width: 6),
                                      // Texto
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$percent%',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              label,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
  }
}

class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double mid = size.height / 2;
    final double w = size.width;

    final path = Path()
      ..moveTo(w - 16, 4)
      ..lineTo(w / 4, 4)
      ..quadraticBezierTo(w / 2, 4, w / 2, 8)
      ..lineTo(w / 2, mid - 8)
      ..quadraticBezierTo(w / 2, mid - 4, 2, mid - 2)
      ..quadraticBezierTo(0, mid, 2, mid + 2)
      ..quadraticBezierTo(w / 2, mid + 4, w / 2, mid + 8)
      ..lineTo(w / 2, size.height - 8)
      ..quadraticBezierTo(w / 2, size.height - 4, w / 4, size.height - 4)
      ..lineTo(w - 16, size.height - 4);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
