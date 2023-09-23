import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/LifeCycle.dart';
import 'package:student_app/Component/Notification.dart';
import 'package:student_app/Controller/SettingController.dart';

import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/HomeScreen.dart';
import 'package:student_app/Screen/LogInScreen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(appLifecycleObserver);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  KakaoSdk.init(nativeAppKey: "3dc3a9ef5fd5367f85038b1332c85545");
  await FlutterLocalNotification.init();

  Get.put(SettingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingController>(
      builder: (controller) {
        if (controller.isLoginSuccess.value) {
          return GetMaterialApp(
              title: 'Student App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: controller.brightness,
                  seedColor: controller.seedColor,
                ),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen());
        } else {
          return GetMaterialApp(
              title: 'Student App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: controller.brightness,
                  seedColor: controller.seedColor,
                ),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: LoginScreen());
        }
      },
    );
  }
}
