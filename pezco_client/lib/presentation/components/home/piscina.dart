import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';

class Piscina extends StatefulWidget {
  const Piscina({super.key});

  @override
  State<Piscina> createState() => PiscinaState();
}

class PiscinaState extends State<Piscina> {
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
