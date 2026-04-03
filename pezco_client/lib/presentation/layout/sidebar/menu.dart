import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String label;

  const MenuItem({required this.icon, required this.label});
}

const List<MenuItem> menuItems = [
  MenuItem(icon: Icons.home, label: 'Inicio'),
  MenuItem(icon: Icons.waves, label: 'Piscinas'),
  MenuItem(icon: Icons.bar_chart, label: 'Finanzas'),
  MenuItem(icon: Icons.analytics, label: 'Reportes')
];
