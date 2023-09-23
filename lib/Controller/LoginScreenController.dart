import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:http/http.dart' as http;
import 'package:student_app/Component/Cookie.dart';
import 'package:student_app/Controller/SettingController.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/HomeScreen.dart';

class LoginScreenController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var storage = const FlutterSecureStorage();

  @override
  void onInit() async {
    super.onInit();
    var userId = await storage.read(key: "id");
    if (userId != null) {
      var userPassword = await storage.read(key: "password");
      logInRequest(null, userId, userPassword);
    }
  }

  Future<void> logInRequest(BuildContext? context, String? savedId, String? savedPassword) async {
    final url = Uri.parse('https://$HOST/api/auth/login');
    final Map<String, dynamic> requestBody = {"user_id": savedId ?? idController.text, "user_password": savedPassword ?? passwordController.text};
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
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("쿠키 저장 오류"),
            ),
          );
        }
      } else {
        await saveCookieToSecureStorage(uid, accessToken, refreshToken);
        if (savedId == null) {
          await storage.write(key: 'id', value: idController.text);
          await storage.write(key: 'password', value: passwordController.text);
        }
        loginSuccess();
      }
    }
    if (isHttpRequestFailure(response)) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("확인 후 다시 시도해주세요"),
          ),
        );
      }
    }
  }

  void loginSuccess() {
    Get.find<SettingController>().isLoginSuccess.value = true;
    Get.delete<LoginScreenController>();
  }
}
