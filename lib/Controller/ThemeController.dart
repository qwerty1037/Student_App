import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Color> kThemeSeedColors = [
  Colors.cyan,
  Colors.blue,
  Colors.deepPurple,
  Colors.pink,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.teal,
  Colors.indigo,
];

class ThemeController extends GetxController {
  final RxInt _seedColorIndex = 0.obs;
  RxBool isDark = false.obs;
  Color get seedColor => kThemeSeedColors[_seedColorIndex.value];
  int get seedColorIndex => _seedColorIndex.value;

  set seedColorIndex(int index) {
    _seedColorIndex.value = index;
  }

  Brightness get brightness =>
      isDark.value ? Brightness.dark : Brightness.light;
}
