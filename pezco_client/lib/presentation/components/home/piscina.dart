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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Color(0xff000000),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      )
                    ),
                    child: Center(
                      child: const Icon(
                        Icons.waves,
                        color: AppColors.backgroundElementP,
                        size: 30,
                      ),
                    ),
                  ),
                  Text("Piscina", style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: const Icon(
                        Icons.navigate_next,
                        color: AppColors.backgroundElementP,
                        size: 28,
                      ),
                    ),
                  ),
                ],
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
