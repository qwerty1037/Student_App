import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Controller/ThemeController.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/HomeScreen.dart';

void main() {
  Get.put(ThemeController());
  Get.put(TotalController());
  Get.put(SettingController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: themeController.brightness,
            seedColor: themeController.seedColor,
          ),
          // textTheme:
          // GoogleFonts.notoSansNKoTextTheme(Theme.of(context).textTheme),

          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
