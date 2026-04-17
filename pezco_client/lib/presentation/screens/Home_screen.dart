import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/presentation/components/header.dart';
import 'package:pezco_client/presentation/components/home/diversidad.dart';
import 'package:pezco_client/presentation/components/home/estadistica.dart';
import 'package:pezco_client/presentation/components/home/piscina.dart';
import 'package:pezco_client/presentation/components/home/proyeccion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.background,
      child: Column(
        children: [
          Expanded(flex: 1, child: Header()),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 450,
                    height: 400,
                    color: AppColors.background,
                    child: const Proyeccion(),
                  ),
                  const SizedBox(width: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 220,
                            height: 400,
                            color: Colors.transparent,
                            child: Piscina(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.background,
                      child: const Estadistica(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        color: Colors.transparent,
                        child: Diversidad(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
