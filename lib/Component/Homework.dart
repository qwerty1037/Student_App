import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';

class HomeWork {
  HomeWork({required this.title, required this.problems, required this.deadLine, required this.teacherName});

  String title;
  List<Problem> problems = [];
  DateTime deadLine;
  String teacherName;
  RxBool isFinish = false.obs;

  void checkFinished() {
    bool temp = true;
    problems.forEach((element) {
      if (element.isSolved.value == false) {
        temp = false;
      }
    });
    if (temp == true) {
      isFinish.value = true;
    }
  }
}
