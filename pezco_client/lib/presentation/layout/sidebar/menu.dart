import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem {
  final IconData icon;
  final String label;

  const MenuItem({required this.icon, required this.label});
}

const List<MenuItem> menuItems = [
  MenuItem(icon: FontAwesomeIcons.solidHouse, label: 'Inicio'),
  MenuItem(icon: FontAwesomeIcons.water, label: 'Piscinas'),
  MenuItem(icon: FontAwesomeIcons.chartSimple, label: 'Finanzas'),
  MenuItem(icon: FontAwesomeIcons.squarePollVertical, label: 'Reportes')
];
