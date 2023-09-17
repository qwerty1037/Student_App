import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:http/http.dart' as http;
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/HomeScreen.dart';

class LoginScreenController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> logInRequest(BuildContext context) async {
    final url = Uri.parse('http://$HOST/api/auth/login');
    final Map<String, dynamic> requestBody = {"user_id": idController.text, "user_password": passwordController.text};
    final headers = {"Content-type": "application/json"};

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );
    if (isHttpRequestSuccess(response)) {
      String? cookieList = response.headers["set-cookie"];

      String? uid = getCookieValue(cookieList!, "uid");
      String? accessToken = getCookieValue(cookieList, "access_token");
      String? refreshToken = getCookieValue(cookieList, "refresh_token");

      if (uid == null || accessToken == null || refreshToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("쿠키 저장 오류"),
          ),
        );
      } else {
        await saveCookieToSecureStorage(uid, accessToken, refreshToken);

        loginSuccess();
      }
    }
    if (isHttpRequestFailure(response)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("등록되지 않은 아이디입니다"),
        ),
      );
    }
  }

  ///쿠키를 안전한 보관소에 저장하는 함수
  Future<void> saveCookieToSecureStorage(String uid, String accessToken, String refreshToken) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: 'uid', value: uid);
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  ///쿠키 headder와 cookieName을 파라미터로 받아 이름에 해당하는 내용을 추출하는 함수
  String? getCookieValue(String cookieHeader, String cookieName) {
    if (cookieHeader.isNotEmpty) {
      List<String> cookies = cookieHeader.split(RegExp(r';|,'));
      for (String cookie in cookies) {
        cookie = cookie.trim();
        if (cookie.startsWith('$cookieName=')) {
          return cookie.substring(cookieName.length + 1);
        }
      }
    }
    return null;
  }

  void loginSuccess() {
    print("왜안되노");
    Get.off(() => const HomeScreen());
    Get.delete<LoginScreenController>();
  }
}
