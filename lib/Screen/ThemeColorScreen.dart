import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Controller/ThemeController.dart';

class ThemeColorSelectScreen extends StatelessWidget {
  ThemeColorSelectScreen({super.key});
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Obx(
        () => SettingsList(
          sections: [
            SettingsSection(tiles: [
              SettingsTile(
                title: "Cyan",
                trailing: trailingWidget(0),
                onPressed: (BuildContext context) {
                  changeThemeColor(0);
                },
              ),
              SettingsTile(
                title: "Blue",
                trailing: trailingWidget(1),
                onPressed: (BuildContext context) {
                  changeThemeColor(1);
                },
              ),
              SettingsTile(
                title: "Purple",
                trailing: trailingWidget(2),
                onPressed: (BuildContext context) {
                  changeThemeColor(2);
                },
              ),
              SettingsTile(
                title: "Pink",
                trailing: trailingWidget(3),
                onPressed: (BuildContext context) {
                  changeThemeColor(3);
                },
              ),
              SettingsTile(
                title: "Orange",
                trailing: trailingWidget(4),
                onPressed: (BuildContext context) {
                  changeThemeColor(4);
                },
              ),
              SettingsTile(
                title: "Yellow",
                trailing: trailingWidget(5),
                onPressed: (BuildContext context) {
                  changeThemeColor(5);
                },
              ),
              SettingsTile(
                title: "Green",
                trailing: trailingWidget(6),
                onPressed: (BuildContext context) {
                  changeThemeColor(6);
                },
              ),
              SettingsTile(
                title: "Teal",
                trailing: trailingWidget(7),
                onPressed: (BuildContext context) {
                  changeThemeColor(7);
                },
              ),
              SettingsTile(
                title: "Indigo",
                trailing: trailingWidget(8),
                onPressed: (BuildContext context) {
                  changeThemeColor(8);
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (themeController.seedColorIndex == index) ? const Icon(Icons.check, color: Colors.blue) : const Icon(null);
  }

  void changeThemeColor(int index) {
    themeController.seedColorIndex = index;
    LocalStorage("User").setItem("seedColor", index);
  }
}
