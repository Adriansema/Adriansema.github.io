import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/presentation/components/headComponent.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.transparent,
                  child: HeadComponent(
                    title: "Estadistica",
                    action: true,
                    iconMain: FontAwesomeIcons.chartSimple,
                    iconGo: FontAwesomeIcons.angleRight,
                    claro: false,
                    letra: 0.4,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundComponent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
