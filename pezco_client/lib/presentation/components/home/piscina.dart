import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/core/responsive.dart';
import 'package:pezco_client/presentation/components/headComponent.dart';

class Piscina extends StatefulWidget {
  final bool? home;

  const Piscina({super.key, this.home});

  @override
  State<Piscina> createState() => PiscinaState();
}

class PiscinaState extends State<Piscina> {
  @override
  Widget build(BuildContext context) {
    final isCompact = ResponsiveSize.isCompactDevice(context);

    if (isCompact && widget.home == true) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: HeadComponent(
            title: "Piscina",
            action: true,
            iconMain: FontAwesomeIcons.water,
            iconGo: FontAwesomeIcons.angleRight,
            letra: 0.4,
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundComponent,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: HeadComponent(
                  title: "Piscina",
                  action: true,
                  iconMain: FontAwesomeIcons.water,
                  iconGo: FontAwesomeIcons.angleRight,
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
          ),
        ),
      );
    }
  }
}
