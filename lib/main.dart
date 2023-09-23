import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/LifeCycle.dart';
import 'package:student_app/Component/Notification.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Controller/ThemeController.dart';
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
  Get.put(ThemeController());

  Get.put(SettingController());
  await FlutterLocalNotification.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {


    return Obx(() => GetMaterialApp(
        title: 'Student App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: themeController.brightness,
            seedColor: themeController.seedColor,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()));
  }
}
