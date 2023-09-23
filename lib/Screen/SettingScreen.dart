import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Component/Notification.dart';

import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Screen/LoginScreen.dart';
import 'package:student_app/Screen/ThemeColorScreen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          "Setting",
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SettingsList(
          sections: [
            SettingsSection(
              title: '테마',
              tiles: [
                SettingsTile(
                  title: 'Theme Color',
                  subtitle: switch (settingController.seedColorIndex + 1) {
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
                  leading: const Icon(Icons.palette),
                  onPressed: (BuildContext context) async {
                    Get.to(() => ThemeColorSelectScreen());
                  },
                ),
                // SettingsTile
                SettingsTile.switchTile(
                  title: 'Darkmode',
                  leading: const Icon(Icons.dark_mode),
                  switchValue: settingController.isDark.value,
                  onToggle: (bool value) {
                    settingController.isDark.value = value;

                    LocalStorage("Setting").setItem("isDark", value);
                  },
                ),
              ],
            ),
            SettingsSection(
              title: '계정',
              tiles: [
                SettingsTile.switchTile(
                  title: "과제 알림",
                  subtitle: "과제가 나왔을 때 푸시 알림을 받으세요.",
                  onToggle: (bool value) {},
                  switchValue: settingController.taskPushAlert,
                ),
                SettingsTile(
                  title: "알림 테스트",
                  onPressed: (BuildContext context) {
                    FlutterLocalNotification.showNotification();
                  },
                ),
                SettingsTile(
                  title: '로그아웃',
                  leading: const Icon(Icons.logout),
                  onPressed: (BuildContext context) async {
                    var storage = const FlutterSecureStorage();
                    await storage.delete(key: 'id');
                    await storage.delete(key: 'password');

                    settingController.isLoginSuccess.value = false;
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
    final settingController = Get.find<SettingController>();

    return Obx(
      () => GestureDetector(
        onTap: () {
          settingController.seedColorIndex = kThemeSeedColors.indexOf(color);
          Get.changeTheme(ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(seedColor: settingController.seedColor),
            useMaterial3: true,
          ));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: color,
            child: settingController.seedColor == color
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
