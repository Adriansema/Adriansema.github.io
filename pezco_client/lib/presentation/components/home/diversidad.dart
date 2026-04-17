import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';

class Diversidad extends StatefulWidget {
  const Diversidad({super.key});

  @override
  State<Diversidad> createState() => _DiversidadState();
}

class _DiversidadState extends State<Diversidad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundComponent,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
    );
  }
}