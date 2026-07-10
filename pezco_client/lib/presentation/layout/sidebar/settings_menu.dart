import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum SettingsAction {
  perfil,
  personalizacion,
  ayuda,
  soporte,
  cerrarSesion,
}

class SettingsMenuItem {
  final IconData icon;
  final String label;
  final SettingsAction action;

  const SettingsMenuItem({
    required this.icon,
    required this.label,
    required this.action,
  });
}

const List<SettingsMenuItem> settingsMenuItems = [
  SettingsMenuItem(
    icon: FontAwesomeIcons.user,
    label: 'Perfil',
    action: SettingsAction.perfil,
  ),
  SettingsMenuItem(
    icon: FontAwesomeIcons.paintbrush,
    label: 'Personalización',
    action: SettingsAction.personalizacion,
  ),
  SettingsMenuItem(
    icon: FontAwesomeIcons.circleQuestion,
    label: 'Dudas e inquietudes',
    action: SettingsAction.ayuda,
  ),
  SettingsMenuItem(
    icon: FontAwesomeIcons.headset,
    label: 'Contactar soporte',
    action: SettingsAction.soporte,
  ),
  SettingsMenuItem(
    icon: FontAwesomeIcons.rightFromBracket,
    label: 'Cerrar sesión',
    action: SettingsAction.cerrarSesion,
  ),
];