import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class Proyeccion extends StatefulWidget {
  const Proyeccion({super.key});

  @override
  State<Proyeccion> createState() => _ProyeccionState();
}

class _ProyeccionState extends State<Proyeccion> {
  bool _hoveredP = false;
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxheight = constraints.maxHeight;
                  return SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: maxheight,
                          height: maxheight,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundElement,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(5.8),
                            child: Icon(
                              Icons.flag_rounded,
                              color: Color(0xFF000000),
                              size: maxheight * 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Proyección",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 20,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: HoverRegion(
                            onEnter: () => setState(() => _hoveredP = true),
                            onExit: () => setState(() => _hoveredP = false),
                            child: Container(
                              width: maxheight,
                              height: maxheight,
                              decoration: BoxDecoration(
                                color: _hoveredP ? AppColors.backgroundComponentSelected : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Icon(
                                Icons.navigate_next,
                                color: _hoveredP ? Color(0xFF000000) : Color(0x80000000),
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                                              child: Icon(
                                                Icons.gps_fixed,
                                                color: Color(0xFF000000),
                                                size: 20,
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
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    color: _hoveredG ? Color(0xFF000000) : Color(0x80000000),
                                                    size: 20,
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
                                              child: Icon(
                                                Icons.checklist_rtl,
                                                color: Color(0xFF000000),
                                                size: 20,
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
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    color: _hoveredT ? Color(0xFF000000) : Color(0x80000000),
                                                    size: 20,
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
