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
  //ToDo :
  //homework가 false인 개수 새서 맨 처음 페이지에서 보여주기, 폴더와 문제 언제 업데이트? 사이에 종료되면 저장시키기
  //로그인, 회원 가입 페이지 만들기 및 안전 storage 붙이기
  //타이머 업데이트 안되면 페이지 전달하는 부분 바꾸기
}
