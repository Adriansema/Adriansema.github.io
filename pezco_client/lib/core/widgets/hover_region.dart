import 'package:flutter/material.dart';

class HoverRegion extends StatelessWidget {
  final Widget child;
  final void Function()? onEnter;
  final void Function()? onExit;

  const HoverRegion({
    super.key,
    required this.child,
    this.onEnter,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEnter?.call(),
      onExit: (_) => onExit?.call(),
      child: child,
    );
  }
}