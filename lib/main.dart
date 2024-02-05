import 'package:firebase_auth/firebase_auth.dart' as f;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_app/Component/LifeCycle.dart';
import 'package:student_app/Component/Notification.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Screen/HomeScreen.dart';
import 'package:student_app/Screen/LogInScreen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:student_app/firebase_options.dart';

//처음 디버깅시 오류가 생길 경우 firebase 관련 문제이니 관련 코드 주석 처리 후 실행. firebase는 알림 보내는 기능 구현을 준비할 때 사용했음.
//카카오 debug, release 키의 경우 추후 개발시 새 아이디로 재발급 후 사용 요망.(현재 카카오는 처음 회원가입 부분에서 인증 용도로만 사용)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLifecycleObserver = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(appLifecycleObserver);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(debug: true);
  await Permission.storage.request();
  KakaoSdk.init(nativeAppKey: "3dc3a9ef5fd5367f85038b1332c85545");
  Get.put(SettingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingController>(
      builder: (controller) {
        return GetMaterialApp(
          initialBinding: BindingsBuilder(() {
            Get.put(
              NotificationController(),
              permanent: true,
            );
          }),
          title: '에듀허브 학생용',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              brightness: controller.brightness,
              seedColor: controller.seedColor,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: controller.isLoginSuccess.value ? HomeScreen() : LoginScreen(),
        );
      },
    );
  }
}
