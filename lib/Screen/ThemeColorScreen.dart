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
                leading: leadingWidget(0),
                trailing: trailingWidget(0),
                onPressed: (BuildContext context) {
                  changeThemeColor(0);
                },
              ),
              SettingsTile(
                title: "Blue",
                leading: leadingWidget(1),
                trailing: trailingWidget(1),
                onPressed: (BuildContext context) {
                  changeThemeColor(1);
                },
              ),
              SettingsTile(
                title: "Purple",
                leading: leadingWidget(2),
                trailing: trailingWidget(2),
                onPressed: (BuildContext context) {
                  changeThemeColor(2);
                },
              ),
              SettingsTile(
                title: "Pink",
                leading: leadingWidget(3),
                trailing: trailingWidget(3),
                onPressed: (BuildContext context) {
                  changeThemeColor(3);
                },
              ),
              SettingsTile(
                title: "Orange",
                leading: leadingWidget(4),
                trailing: trailingWidget(4),
                onPressed: (BuildContext context) {
                  changeThemeColor(4);
                },
              ),
              SettingsTile(
                title: "Yellow",
                leading: leadingWidget(5),
                trailing: trailingWidget(5),
                onPressed: (BuildContext context) {
                  changeThemeColor(5);
                },
              ),
              SettingsTile(
                title: "Green",
                leading: leadingWidget(6),
                trailing: trailingWidget(6),
                onPressed: (BuildContext context) {
                  changeThemeColor(6);
                },
              ),
              SettingsTile(
                title: "Teal",
                leading: leadingWidget(7),
                trailing: trailingWidget(7),
                onPressed: (BuildContext context) {
                  changeThemeColor(7);
                },
              ),
              SettingsTile(
                title: "Indigo",
                leading: leadingWidget(8),
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

  Widget leadingWidget(int index) {
    Color color = kThemeSeedColors[index];
    return CircleAvatar(
      radius: 16,
      backgroundColor: color,
    );
  }

  Widget trailingWidget(int index) {
    return (themeController.seedColorIndex == index)
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }

  void changeThemeColor(int index) {
    themeController.seedColorIndex = index;
    LocalStorage("User").setItem("seedColor", index);
  }
}
