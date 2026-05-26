import 'package:flutter/material.dart';

class EspeciesList {
  final int cantidad;
  final String especie;

  const EspeciesList({required this.cantidad, required this.especie });
}

const List<EspeciesList> especiesLists = [
  EspeciesList(cantidad: 10, especie: 'Tilápia'),
  EspeciesList(cantidad: 5, especie: 'Betta'),
  EspeciesList(cantidad: 8, especie: 'Cirrhinus'),
  EspeciesList(cantidad: 3, especie: 'Hypophthalmus')
];
