import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app/Controller/ThemeController.dart';
import 'package:student_app/Screen/HomeScreen.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student App',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(
        //  seedColor: Get.find<ThemeController>().seedColor),
        //textTheme:
        //   GoogleFonts.notoSansNKoTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
