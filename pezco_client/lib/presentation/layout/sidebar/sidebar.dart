import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';

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
      color: AppColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 140,
                width: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                      color: AppColors.backgroundComponentWhite,
                        borderRadius: BorderRadius.circular(40),
                      ),
                        child: Image.asset("assets/images/pezco_logo.png"),
                    ),
                    SizedBox(
                      height: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              _SidebarItem(
                icon: Icons.home_outlined,
                label: 'Inicio',
                selected: selectedIndex == 0,
                onTap: () => onItemSelected(0),
              ),
              _SidebarItem(
                icon: Icons.settings_outlined,
                label: 'Configuración',
                selected: selectedIndex == 1,
                onTap: () => onItemSelected(1),
              ),
            ],
          ),
        ),
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
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      onTap: onTap,
    );
  }
}
