import 'package:flutter/material.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

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
        child: Container(
          width: isTablet || isCompact ? 30 : 50,
          height: isTablet || isCompact ? 30 : 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Icon(
              Icons.settings,
              color: _hovered
                          ? const Color(0x99000000)
                          : const Color(0x80000000),
              size: isTablet || isCompact ? 28 : 31,
            ),
          ),
        ),
      ),
    );
  }
}
