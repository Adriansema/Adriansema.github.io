import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';

class Proyeccion extends StatefulWidget {
  const Proyeccion({super.key});

  @override
  State<Proyeccion> createState() => _ProyeccionState();
}

class _ProyeccionState extends State<Proyeccion> {
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
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundComponentMenu,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(5.8),
                      child: Icon(
                        Icons.flag_rounded,
                        color: Color(0xFF000000),
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Proyección",
                    style: TextStyle(color: Color(0xFF000000), fontSize: 20),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Icon(
                      Icons.navigate_next,
                      color: Color(0xFF000000),
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: 280,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundComponentMenu,
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
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Color(0xFF000000),
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundComponentMenu,
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
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color: Color(0xFF000000),
                                        size: 20,
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
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                      color: AppColors.backgroundComponentMenu,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
