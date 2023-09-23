import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

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

class SettingController extends GetxController {
  RxBool isLoginSuccess = false.obs;
  bool taskPushAlert = true;
  final RxInt _seedColorIndex = 0.obs;
  RxBool isDark = false.obs;
  Color get seedColor => kThemeSeedColors[_seedColorIndex.value];
  int get seedColorIndex => _seedColorIndex.value;

  set seedColorIndex(int index) {
    _seedColorIndex.value = index;
  }

  Brightness get brightness => isDark.value ? Brightness.dark : Brightness.light;

  @override
  void onInit() async {
    super.onInit();

    var localstorage = LocalStorage("Setting");

    _seedColorIndex.value = localstorage.getItem("seedColor") ?? 0;
    isDark.value = localstorage.getItem("isDark") ?? false;
  }
}
