import 'package:flutter/material.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Component/Problem.dart';

List<HomeWork> ExampleHomeWork = [
  HomeWork(deadLine: DateTime.utc(2023, 9, 21), title: "첫 과제", teacherName: "이동규", problems: [
    Problem(questions: [
      "다음중 옳은 것을 고르시오?",
    ]),
    Problem(questions: ["다음중 틀린 것은?"]),
  ]),
  HomeWork(deadLine: DateTime.utc(2023, 9, 22), title: "두번째 과제", teacherName: "김성현", problems: [
    Problem(questions: ["1+1 = ?"])
  ]),
];
