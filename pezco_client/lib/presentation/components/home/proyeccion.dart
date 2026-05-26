import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';
import 'package:pezco_client/presentation/components/headComponent.dart';

class Proyeccion extends StatefulWidget {
  const Proyeccion({super.key});

  @override
  State<Proyeccion> createState() => _ProyeccionState();
}

class _ProyeccionState extends State<Proyeccion> {
  bool _hoveredG = false;
  bool _hoveredT = false;

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
        padding: EdgeInsets.all(20),
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
            SizedBox(height: 20),
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 280),
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
                              Container(
                                width: maxWidth,
                                height: maxWidth,
                                constraints: BoxConstraints(
                                  maxHeight: 100,
                                  maxWidth: 100,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.backgroundElement,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.crosshairs,
                                                  color: Color(0xFF000000),
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: HoverRegion(
                                                onEnter: () => setState(() => _hoveredG = true,),
                                                onExit: () => setState(() => _hoveredG = false,),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                    color: _hoveredG ? AppColors.backgroundComponentSelected : Colors.transparent,
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.angleRight,
                                                      color: _hoveredG ? Color(0xFF000000) : Color(0x80000000),
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: maxWidth,
                                height: maxWidth,
                                constraints: BoxConstraints(
                                  maxHeight: 100,
                                  maxWidth: 100,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.backgroundElement,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.listCheck,
                                                  color: Color(0xFF000000),
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                            MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: HoverRegion(
                                                onEnter: () => setState(() => _hoveredT = true,),
                                                onExit: () => setState(() => _hoveredT = false,),
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                    color: _hoveredT ? AppColors.backgroundComponentSelected : Colors.transparent,
                                                  ),
                                                  child: Center(
                                                    child: FaIcon(
                                                      FontAwesomeIcons.angleRight,
                                                      color: _hoveredT ? Color(0xFF000000) : Color(0x80000000),
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundElement,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
