import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Test/HomeWork_Example.dart';

class TotalController extends GetxController {
  RxList<HomeWork> HomeWorks = LocalStorage("User").getItem("HomeWork") ?? ExampleHomeWork.obs;

  @override
  void onInit() {
    super.onInit();
    if (LocalStorage("User").getItem("HomeWork") != null) {
      HomeWorks.value = LocalStorage("User").getItem("HomeWork");
    }
  }
}
