// lib/presentation/layout/sidebar/sidebar.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/perfil_avatar.dart';
import 'package:pezco_client/presentation/components/settings.dart';
import 'package:pezco_client/presentation/layout/sidebar/sidebar_Item.dart';
import 'package:pezco_client/presentation/layout/sidebar/menu.dart';
import 'package:pezco_client/presentation/layout/sidebar/settings_menu.dart';
import 'package:pezco_client/providers/auth_provider.dart';

class Sidebar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _mostrandoSettings = false;

  Future<void> _manejarAccionSettings(
      BuildContext context, SettingsAction accion) async {
    switch (accion) {
      case SettingsAction.cerrarSesion:
        await _confirmarLogout(context);
        break;
      case SettingsAction.perfil:
      case SettingsAction.personalizacion:
      case SettingsAction.ayuda:
      case SettingsAction.soporte:
        // Pantallas pendientes de definir
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Próximamente')),
        );
        break;
    }
  }

  Future<void> _confirmarLogout(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Seguro que quieres cerrar tu sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirmar == true && context.mounted) {
      await context.read<AuthProvider>().logout();
    }
  }

  void _abrirSettingsCompact(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: settingsMenuItems.map((item) {
            return ListTile(
              leading: FaIcon(item.icon, size: 20),
              title: Text(item.label),
              onTap: () {
                Navigator.of(ctx).pop();
                _manejarAccionSettings(context, item.action);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

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
                      selected: widget.selectedIndex == entry.key,
                      onTap: () => widget.onItemSelected(entry.key),
                    ),
                  ),
                );
              }),
              Settings(onTap: () => _abrirSettingsCompact(context)),
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
                    const SizedBox(
                      height: 0.5,
                      width: double.infinity,
                      child: DecoratedBox(
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
                  if (_mostrandoSettings)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: SidebarItemIcon(
                          icon: FontAwesomeIcons.arrowLeft,
                          selected: false,
                          onTap: () =>
                              setState(() => _mostrandoSettings = false),
                        ),
                      ),
                    ),
                  Column(
                    spacing: 10,
                    children: _mostrandoSettings
                        ? settingsMenuItems.map((item) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SidebarItemIcon(
                                icon: item.icon,
                                selected: false,
                                onTap: () =>
                                    _manejarAccionSettings(context, item.action),
                              ),
                            );
                          }).toList()
                        : menuItems.asMap().entries.map((entry) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: SidebarItemIcon(
                                icon: entry.value.icon,
                                selected: widget.selectedIndex == entry.key,
                                onTap: () => widget.onItemSelected(entry.key),
                              ),
                            );
                          }).toList(),
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
                    Settings(
                      active: _mostrandoSettings,
                      onTap: () => setState(
                          () => _mostrandoSettings = !_mostrandoSettings),
                    ),
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
                    const SizedBox(
                      height: 0.5,
                      width: double.infinity,
                      child: DecoratedBox(
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
                    if (_mostrandoSettings)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SidebarItem(
                            icon: FontAwesomeIcons.arrowLeft,
                            label: 'Volver',
                            selected: false,
                            onTap: () =>
                                setState(() => _mostrandoSettings = false),
                          ),
                        ),
                      ),
                    Column(
                      spacing: 10,
                      children: [
                        const SizedBox(height: 10),
                        ..._mostrandoSettings
                            ? settingsMenuItems.map((item) {
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SidebarItem(
                                    icon: item.icon,
                                    label: item.label,
                                    selected: false,
                                    onTap: () => _manejarAccionSettings(
                                        context, item.action),
                                  ),
                                );
                              })
                            : menuItems.asMap().entries.map((entry) {
                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: SidebarItem(
                                    icon: entry.value.icon,
                                    label: entry.value.label,
                                    selected:
                                        widget.selectedIndex == entry.key,
                                    onTap: () =>
                                        widget.onItemSelected(entry.key),
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
                    Settings(
                      active: _mostrandoSettings,
                      onTap: () => setState(
                          () => _mostrandoSettings = !_mostrandoSettings),
                    ),
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