import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/presentation/layout/sidebar/sidebar.dart';
import 'package:pezco_client/presentation/screens/home_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;

  // Agrega aquí cada pantalla que tengas
  final List<Widget> _screens = const [
    HomeScreen(),
    // SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Sidebar con ancho fijo
          SizedBox(
            width: 200,
            child: Sidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) => setState(() => _selectedIndex = index),
            ),
          ),
          // Línea divisoria opcional
          const VerticalDivider(width: 1),
          // Contenido: ocupa todo el espacio restante
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}