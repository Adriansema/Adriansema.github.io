import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';
import 'package:pezco_client/presentation/components/perfil_avatar.dart';
import 'package:pezco_client/presentation/components/settings.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final isCompact = ResponsiveSize.isCompactDevice(context);
    final isTablet = ResponsiveSize.isTablet(context);
    final padding = ResponsiveSize.getHeaderPadding(context);

    if (isCompact) {
      return Container(
        width: double.infinity,
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.elements, width: 1),
          ),
          color: AppColors.backgroundComponent,
        ),
        child: Padding(
          padding: padding,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Bienvendido',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: AppColors.elements,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(width: 25, height: 25, child: Settings()),
                      const SizedBox(width: 10),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: PerfilAvatar(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (isTablet) {
      return Container(
        width: double.infinity,
        height: 100,
        color: AppColors.backgroundComponent,
        child: Padding(
          padding: padding,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundComponent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'BIENVENIDO',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.elements,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Buscar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 250,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: HoverRegion(
                            onEnter: () => setState(() => _hovered = true),
                            onExit: () => setState(() => _hovered = false),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: _hovered
                                      ? AppColors.backgroundComponentSelected
                                      : AppColors.backgroundElement,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: -5,
                                        bottom: -10,
                                        child: Icon(
                                          Icons.person,
                                          color: const Color(0x80000000),
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nombre"),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        color: AppColors.backgroundComponent,
        child: Padding(
          padding: padding,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundComponent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: const Text(
                      'BIENVENDIDO',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.elements,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Buscar",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 400,
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const PerfilAvatar(),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Nombre"),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
