import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Controller/TotalController.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final storage = const FlutterSecureStorage();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      var id = await const FlutterSecureStorage().read(key: "id");

      List<dynamic> homeWorkJsonList = Get.find<TotalController>()
          .homeWorks
          .map((homeWork) => homeWork.toJson())
          .toList();
      String homeWorkJsonString = jsonEncode(homeWorkJsonList);
      List<dynamic> AnswerNoteJsonList = Get.find<TotalController>()
          .answerNote
          .map((answerNote) => answerNote.toJson())
          .toList();
      String answerNoteJsonString = jsonEncode(AnswerNoteJsonList);

      await LocalStorage(id!).setItem("HomeWork", homeWorkJsonString);
      await LocalStorage(id).setItem("AnswerNote", answerNoteJsonString);
      debugPrint("=======================================");
      debugPrint("id: $id");
      debugPrint(LocalStorage(id).getItem("HomeWork").toString());
      debugPrint(LocalStorage(id).getItem("AnswerNote").toString());
    }
  }
}
