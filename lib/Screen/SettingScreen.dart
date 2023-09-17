import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Controller/ThemeController.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:student_app/Screen/ThemeColorScreen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final themeController = Get.find<ThemeController>();
  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Obx(
        () => SettingsList(
          sections: [
            SettingsSection(
              title: "내 알림",
              tiles: [
                SettingsTile.switchTile(
                  title: "과제 알림",
                  subtitle: "과제가 나왔을 때 푸시 알림을 받으세요.",
                  onToggle: (bool value) {},
                  switchValue: settingController.taskPushAlert,
                ),
              ],
            ),
            SettingsSection(
              title: 'Theme',
              tiles: [
                SettingsTile(
                  title: 'Theme Color',
                  subtitle: switch (themeController.seedColorIndex + 1) {
                    1 => 'Cyan',
                    2 => 'Blue',
                    3 => 'Purple',
                    4 => 'Pink',
                    5 => 'Orange',
                    6 => 'Yellow',
                    7 => 'Green',
                    8 => 'Teal',
                    9 => 'Indigo',
                    _ => 'error',
                  },
                  leading: const Icon(Icons.pallet),
                  onPressed: (BuildContext context) {
                    Get.to(() => ThemeColorSelectScreen());
                  },
                ),
                // SettingsTile
                SettingsTile.switchTile(
                  title: 'Darkmode',
                  leading: const Icon(Icons.fingerprint),
                  switchValue: themeController.isDark.value,
                  onToggle: (bool value) {
                    themeController.isDark.value = value;
                    LocalStorage("User").setItem("isDark", value);
                  },
                ),
              ],
            ),
          ],
        ),
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
            colorScheme: ColorScheme.fromSeed(seedColor: themeController.seedColor),
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
