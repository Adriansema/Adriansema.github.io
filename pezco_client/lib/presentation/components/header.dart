import 'package:flutter/material.dart';
import 'package:pezco_client/core/app_color.dart';
import 'package:pezco_client/presentation/components/perfil_avatar.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.backgroundComponent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundComponent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: const Text(
                    'BIENVENDIDO',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.elements,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Buscar",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  width: 400,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const PerfilAvatar(),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Nombre"),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
