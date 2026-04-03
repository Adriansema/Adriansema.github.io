import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
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
                        final index = entry.key;
                        final item = entry.value;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: 50,
                            width: 160,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundComponentMenu,
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
                                child: _SidebarItem(
                                  icon: item.icon,
                                  label: item.label,
                                  selected: selectedIndex == index,
                                  onTap: () => onItemSelected(index),
                                ),
                              ),
                            ),
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
            child: const Center(child: Text('footer')),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(14),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 22),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
