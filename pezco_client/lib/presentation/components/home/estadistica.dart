import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';

class Estadistica extends StatefulWidget {
  const Estadistica({super.key});

  @override
  State<Estadistica> createState() => _EstadisticaState();
}

class _EstadisticaState extends State<Estadistica> {
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