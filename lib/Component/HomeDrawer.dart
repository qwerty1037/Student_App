import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Screen/HomeScreen.dart';
import 'package:student_app/Screen/ProblemListScreen.dart';
import 'package:student_app/Screen/SettingScreen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 8,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('홈'),
              onTap: () {
                Get.to(() => const HomeScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('과제'),
              onTap: () {
                Get.to(() => const HomeWorkListScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('오답노트'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('설정'),
              onTap: () {
                Get.to(() => SettingScreen());
              },
            ),
          ],
        ),
      );
}
