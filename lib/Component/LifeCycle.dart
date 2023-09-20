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
      await LocalStorage(id!).setItem("HomeWork", Get.find<TotalController>().HomeWorks.value);
    }
  }
}
