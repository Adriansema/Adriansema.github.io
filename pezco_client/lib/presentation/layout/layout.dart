import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/presentation/layout/sidebar/sidebar.dart';
import 'package:pezco_client/presentation/screens/Finanzas_screen.dart';
import 'package:pezco_client/presentation/screens/Piscinas_screen.dart';
import 'package:pezco_client/presentation/screens/Reportes_screen.dart';
import 'package:pezco_client/presentation/screens/home_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PiscinasScreen(),
    FinanzasScreen(),
    ReportesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Sidebar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) => setState(() => _selectedIndex = index),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}