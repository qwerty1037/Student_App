import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Controller/ThemeController.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 30,
                child: const Text("테마 색"),
              ),
              Row(
                children: kThemeSeedColors
                    .map((e) => _buildSeedColorButton(e, context))
                    .toList(),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 30,
                child: const Text("다크 모드"),
              ),
              Obx(
                () => Switch(
                  value: themeController.isDark.value,
                  onChanged: (bool value) {
                    themeController.isDark.value = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildSeedColorButton(Color color, BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GestureDetector(
        onTap: () {
          themeController.seedColorIndex = kThemeSeedColors.indexOf(color);
          Get.changeTheme(ThemeData.light().copyWith(
            colorScheme:
                ColorScheme.fromSeed(seedColor: themeController.seedColor),
            useMaterial3: true,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: color,
            child: themeController.seedColor == color
                ? const Icon(
                    Icons.check,
                    size: 16.0,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
