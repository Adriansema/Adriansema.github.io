// lib/presentation/components/settings.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class Settings extends StatefulWidget {
  final VoidCallback onTap;
  final bool active;

  const Settings({super.key, required this.onTap, this.active = false});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isCompact = ResponsiveSize.isCompactDevice(context);
    final isTablet = ResponsiveSize.isTablet(context);
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: isTablet || isCompact ? 30 : 50,
            height: isTablet || isCompact ? 30 : 50,
            decoration: BoxDecoration(
              color: widget.active
                  ? const Color(0x1A000000)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.gear,
                color: _hovered || widget.active
                    ? const Color(0x99000000)
                    : const Color(0x80000000),
                size: isTablet || isCompact ? 22 : 29,
              ),
            ),
          ),
        ),
      ),
    );
  }
}