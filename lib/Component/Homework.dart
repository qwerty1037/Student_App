import 'package:student_app/Component/Problem.dart';

class HomeWork {
  HomeWork({required this.title, required this.problems, required this.deadLine, required this.teacherName});

  String title;
  List<Problem> problems = [];
  DateTime deadLine;
  String teacherName;
  bool isFinish = false;
}
