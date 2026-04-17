import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
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
    return HoverRegion(
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
                : AppColors.backgroundComponentMenu,
            borderRadius: BorderRadius.circular(40),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              children: [
                Positioned(
                  left: -5,
                  bottom: -16,
                  child: Icon(
                    Icons.person,
                    color: const Color(0x80000000),
                    size: 80,
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