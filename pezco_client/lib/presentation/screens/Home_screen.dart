import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/header.dart';
import 'package:pezco_client/presentation/components/home/diversidad.dart';
import 'package:pezco_client/presentation/components/home/estadistica.dart';
import 'package:pezco_client/presentation/components/home/piscina.dart';
import 'package:pezco_client/presentation/components/home/proyeccion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: ResponsiveSize.getProyeccionWidth(
                                context,
                              ),
                              constraints: BoxConstraints(
                                maxWidth: 450,
                                maxHeight: 400,
                              ),
                              color: AppColors.background,
                              child: const Proyeccion(),
                            ),
                            const SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Container(
                                      width: ResponsiveSize.getPiscinaWidth(
                                        context,
                                      ),
                                      height: ResponsiveSize.getPiscinaHeight(
                                        context,
                                      ),
                                      color: Colors.transparent,
                                      child: Piscina(home: true),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 70,
                              color: Colors.transparent,
                              child: Diversidad(),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 300,
                              color: AppColors.background,
                              child: const Estadistica(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                              child: Header(),
                            ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: isTablet
                                ? (constraints.maxHeight * 0.42).clamp(
                                    300.0,
                                    double.infinity,
                                  )
                                : (constraints.maxHeight * 0.40).clamp(
                                    300.0,
                                    double.infinity,
                                  ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: ResponsiveSize.getProyeccionWidth(
                                      context,
                                    ),
                                    constraints: const BoxConstraints(
                                      maxWidth: 450,
                                      minWidth: 300,
                                      maxHeight: 400,
                                      minHeight: 300,
                                    ),
                                    color: AppColors.background,
                                    child: const Proyeccion(),
                                  ),
                                  const SizedBox(width: 10),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Container(
                                            width: 220,
                                            height: 400,
                                            color: Colors.transparent,
                                            child: Piscina(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: isTablet
                                ? (constraints.maxHeight * 0.42).clamp(
                                    300.0,
                                    double.infinity,
                                  )
                                : (constraints.maxHeight * 0.40).clamp(
                                    300.0,
                                    double.infinity,
                                  ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: AppColors.background,
                                      child: const Estadistica(),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Diversidad(),
                                    ),
                                  ),
                                ],
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
