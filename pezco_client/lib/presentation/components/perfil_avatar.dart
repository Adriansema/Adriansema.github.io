import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class PerfilAvatar extends StatefulWidget {
  const PerfilAvatar({super.key});

  @override
  State<PerfilAvatar> createState() => _PerfilAvatarState();
}

class _PerfilAvatarState extends State<PerfilAvatar> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final isCompact = ResponsiveSize.isCompactDevice(context);
    final isTablet = ResponsiveSize.isTablet(context);
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: double.infinity,
          constraints: const BoxConstraints(
            maxHeight: 70,
          ),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.backgroundComponentSelected
                : AppColors.backgroundElement,
            borderRadius: BorderRadius.circular(40),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double maxheight = constraints.maxHeight;
              return Container(
                height: maxheight,
                width: maxheight,
                color: Colors.transparent,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  children: [
                    if (isTablet)
                      Positioned(
                        left: -5,
                        bottom: -12,
                        child:  Icon(
                          Icons.person,
                          color: const Color(0x80000000),
                          size: 70,
                        ),
                      )
                    else if (isCompact)
                       Positioned(
                        left: -5,
                        bottom: -10,
                        child:  Icon(
                          Icons.person,
                          color: const Color(0x80000000),
                          size: 50,
                        ),
                      )
                    else 
                      Positioned(
                        left: -5,
                        bottom: -16,
                        child:  Icon(
                          Icons.person,
                          color: const Color(0x80000000),
                          size: maxheight + 10,
                        ),
                      )
                  ],
                ),
              ),
            );},
          ),
        ),
      ),
    );
  }
}