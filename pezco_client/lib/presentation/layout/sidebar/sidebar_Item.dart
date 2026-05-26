import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/widgets/hover_region.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          width: 160,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.backgroundComponentSelected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.selected
                      ? const Color(0x99FFFFFF)
                      : _hovered
                      ? const Color(0x99000000)
                      : const Color(0x80000000),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.selected
                        ? const Color(0x99FFFFFF)
                        : _hovered
                        ? const Color(0x99000000)
                        : const Color(0x80000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SidebarItemIcon extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const SidebarItemIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  State<SidebarItemIcon> createState() => _SidebarItemIconState();
}

class _SidebarItemIconState extends State<SidebarItemIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverRegion(
      onEnter: () => setState(() => _hovered = true),
      onExit: () => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.backgroundComponentSelected
                : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.transparent,
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: widget.selected
                  ? const Color(0x99FFFFFF)
                  : _hovered
                  ? const Color(0x99000000)
                  : const Color(0x80000000),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
