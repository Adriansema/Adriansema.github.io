import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/header.dart';
import 'package:pezco_client/presentation/components/home/piscina.dart';

class PiscinasScreen extends StatefulWidget {
  const PiscinasScreen({super.key});

  @override
  State<PiscinasScreen> createState() => _PiscinasScreenState();
}

class _PiscinasScreenState extends State<PiscinasScreen> {
  @override
  Widget build(BuildContext context) {
    final isCompact = ResponsiveSize.isCompactDevice(context);
    final isTablet = ResponsiveSize.isTablet(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      child: Column(
        children: [
          if (isCompact)
            Expanded(
              child: Column(
                children: [
                  const Header(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          const columns = 2;
                          const spacing = 10.0;
                          const targetHeight = 350.0;

                          // ancho de cada item descontando los espacios entre columnas
                          final itemWidth =
                              (constraints.maxWidth - spacing * (columns - 1)) /
                              columns;
                          final ratio = itemWidth / targetHeight;

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  crossAxisSpacing: spacing,
                                  mainAxisSpacing: 10,
                                  childAspectRatio:
                                      ratio, // ← altura controlada aquí
                                ),
                            itemCount: 12,
                            itemBuilder: (context, index) => Piscina(),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          else
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          if (isTablet)
                            const Header()
                          else
                            SizedBox(
                              height: (constraints.maxHeight * 0.14).clamp(
                                120.0,
                                double.infinity,
                              ),
                              child: const Header(),
                            ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: constraints.maxHeight.clamp(
                              300.0,
                              double.infinity,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isTablet ? 2 : 3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                    ),
                                itemCount: 12,
                                itemBuilder: (context, index) => Piscina(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
