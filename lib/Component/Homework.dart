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
    for (var element in problems) {
      if (element.isSolved == false) {
        temp = false;
      }
    }
    if (temp == true) {
      isFinish.value = true;
    }
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> problemListJson = problems.map((problem) => problem.toJson()).toList();
    return {
      'title': title,
      'problems': problemListJson,
      'deadLine': deadLine.toIso8601String(),
      'teacherName': teacherName,
      'isFinish': isFinish.value,
    };
  }

  // Map을 HomeWork 객체로 역직렬화
  factory HomeWork.fromJson(Map<String, dynamic> json) {
    List<dynamic> problemListJson = json['problems'] as List<dynamic>;
    List<Problem> problems = problemListJson.map((problemJson) => Problem.fromJson(problemJson)).toList();

    return HomeWork(
      title: json['title'],
      problems: problems,
      deadLine: DateTime.parse(json['deadLine']),
      teacherName: json['teacherName'],
    )..isFinish.value = json['isFinish'] ?? false;
  }
}
