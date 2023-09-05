import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Color> kThemeSeedColors = [
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.pink,
  Colors.orange
];

class ThemeController extends GetxController {
  RxInt _seedColorIndex = 0.obs;
  Color get seedColor => kThemeSeedColors[_seedColorIndex.value];

  set seedColorIndex(int index) {
    _seedColorIndex.value = index;
  }
}
