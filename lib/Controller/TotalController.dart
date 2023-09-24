import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Cookie.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Test/HomeWork_Example.dart';
import 'package:http/http.dart' as http;
import 'package:student_app/Controller/LoginScreenController.dart';

class TotalController extends GetxController {
  RxList<HomeWork> HomeWorks = ExampleHomeWork.obs; // 추후 ExampleHomeWork부분 []로 변경
  RxList<dynamic> answerNote = [].obs;
  late Timer _timer;
  String? id;
  RxInt unsolvedRemained = 0.obs;
  int totalRemained = 0;

  @override
  void onInit() async {
    super.onInit();

    id = await const FlutterSecureStorage().read(key: "id");

    if (LocalStorage(id!).getItem("HomeWork") != null) {
      HomeWorks.value = LocalStorage(id!).getItem("HomeWork");
    }
    if (LocalStorage(id!).getItem("AnswerNote") != null) {
      answerNote.value = LocalStorage(id!).getItem("AnswerNote");
    }
    DateTime now = DateTime.now();
    for (var element in HomeWorks) {
      if (element.deadLine.compareTo(now) > 0) {
        totalRemained++;
        if (element.isFinish.value == false) {
          unsolvedRemained.value++;
        }
      }
    }
    ever(HomeWorks, (_) {
      DateTime now = DateTime.now();
      int value = 0;
      for (var element in HomeWorks) {
        if (element.deadLine.compareTo(now) > 0 && element.isFinish.value == false) {
          value++;
        }
      }
      unsolvedRemained.value = value;
    });

    _timer = Timer.periodic(const Duration(minutes: 29), (timer) async {
      final url = Uri.parse('https://$HOST/api/auth/refresh');
      final response = await http.post(
        url,
        headers: await defaultHeader(httpContentType.json),
      );

      if (isHttpRequestSuccess(response)) {
        String? cookieList = response.headers["set-cookie"];

        String? uid = getCookieValue(cookieList!, "uid");
        String? accessToken = getCookieValue(cookieList, "access_token");
        String? refreshToken = getCookieValue(cookieList, "refresh_token");
        if (accessToken == null) {
          debugPrint("refresh 토큰 받기 도중 변환 실패");
        } else {
          await saveCookieToSecureStorage(uid!, accessToken, refreshToken!);
        }
      } else if (isHttpRequestFailure(response)) {
        debugPrint(response.statusCode.toString());
        debugPrint("refresh 토큰 받기 오류 발생(서버연결x)");
      }
    });
  }
}
