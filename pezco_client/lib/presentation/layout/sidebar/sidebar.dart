import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/perfil_avatar.dart';
import 'package:pezco_client/presentation/components/settings.dart';
import 'package:pezco_client/presentation/layout/sidebar/sidebar_Item.dart';
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
    final isCompact = ResponsiveSize.isCompactDevice(context);
    final isTablet = ResponsiveSize.isTablet(context);

    if (isCompact) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border(
            top: BorderSide(
              color: Colors.black.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...menuItems.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: SidebarItemIcon(
                      icon: entry.value.icon,
                      selected: selectedIndex == entry.key,
                      onTap: () => onItemSelected(entry.key),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    } else if (isTablet) {
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
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundComponentSelected,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            spreadRadius: 2,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Image.asset("assets/images/logo.png"),
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
              child: ListView(
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      ...menuItems.asMap().entries.map((entry) {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SidebarItemIcon(
                            icon: entry.value.icon,
                            selected: selectedIndex == entry.key,
                            onTap: () => onItemSelected(entry.key),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                color: AppColors.backgroundElement,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Settings(),
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: PerfilAvatar(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
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
                            child: SidebarItem(
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
                color: AppColors.backgroundElement,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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
                    const Settings(),
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
}
