import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';
import 'package:pezco_client/presentation/components/perfil_avatar.dart';
import 'package:pezco_client/presentation/layout/sidebar/menu.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
            child: SizedBox(
              height: 140,
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundComponentSelected,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          spreadRadius: 2,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/pezco_logo.png"),
                  ),
                  SizedBox(
                    height: 0.5,
                    width: double.infinity,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFF000000)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      const SizedBox(height: 10),
                      ...menuItems.asMap().entries.map((entry) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: _SidebarItem(
                            icon: entry.value.icon,
                            label: entry.value.label,
                            selected: selectedIndex == entry.key,
                            onTap: () => onItemSelected(entry.key),
                          ),
                        );
                      }),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              color: AppColors.backgroundComponentMenu,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PerfilAvatar(),
                  const Expanded(child: SizedBox()),
                  const SizedBox(
                    height: 60,
                    width: 0.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xFF000000)),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  const _FooterSettings(),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          width: 160,
          decoration: BoxDecoration(
            color: widget.selected || _hovered
                ? AppColors.backgroundComponentSelected
                : AppColors.backgroundComponentMenu,
            borderRadius: BorderRadius.circular(30),
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1,
              ),
              left: BorderSide(
                color: Colors.white.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.selected || _hovered
                          ? Color(0x99000000)
                          : Color(0x80000000),
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterSettings extends StatefulWidget {
  const _FooterSettings();

  @override
  State<_FooterSettings> createState() => _FooterSettingsState();
}

class _FooterSettingsState extends State<_FooterSettings> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.backgroundComponentSelected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Center(
            child: Icon(Icons.settings, color: Color(0x80000000), size: 31),
          ),
        ),
      ),
    );
  }
}
