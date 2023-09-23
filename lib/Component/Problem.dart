import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';

class Problem {
  Problem({required this.questions, this.minutes = 0, this.seconds = 0, this.answerNote = false});

  int minutes;
  int seconds;
  bool answerNote;

  RxBool isSolved = false.obs;
  // RxBool isSolved = false.obs;
  List<dynamic> questions;
  final problemDrawingController = DrawingController(
    config: DrawConfig(
      color: Colors.black,
      contentType: SimpleLine,
    ),
  );
  final answerDrawingController = DrawingController(
    config: DrawConfig(
      color: Colors.black,
      contentType: SimpleLine,
    ),
  );
  List<dynamic> problemDrawingList = [];
  List<dynamic> answerDrawingList = [];

  void save() {
    problemDrawingList = problemDrawingController.getJsonList();
    answerDrawingList = answerDrawingController.getJsonList();
  }

  void load() {
    for (var element in problemDrawingList) {
      switch (element['type']) {
        case 'SimpleLine':
          problemDrawingController.addContent(SimpleLine.fromJson(element));
        case 'SmoothLine':
          problemDrawingController.addContent(SmoothLine.fromJson(element));
        case 'StraightLine':
          problemDrawingController.addContent(StraightLine.fromJson(element));
        case 'Circle':
          problemDrawingController.addContent(Circle.fromJson(element));
        case 'Eraser':
          problemDrawingController.addContent(Eraser.fromJson(element));
      }
    }
    for (var element in answerDrawingList) {
      switch (element['type']) {
        case 'SimpleLine':
          answerDrawingController.addContent(SimpleLine.fromJson(element));
        case 'SmoothLine':
          answerDrawingController.addContent(SmoothLine.fromJson(element));
        case 'StraightLine':
          answerDrawingController.addContent(StraightLine.fromJson(element));
        case 'Circle':
          answerDrawingController.addContent(Circle.fromJson(element));
        case 'Eraser':
          answerDrawingController.addContent(Eraser.fromJson(element));
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'minutes': minutes,
      'seconds': seconds,
      'answerNote': answerNote,
      'isSolved': isSolved.value,
      'questions': questions,
      'problemDrawingList': problemDrawingList,
      'answerDrawingList': answerDrawingList,
    };
  }

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      minutes: json['minutes'],
      seconds: json['seconds'],
      answerNote: json['answerNote'],
      questions: json['questions'],
    )
      ..isSolved.value = json['isSolved']
      ..problemDrawingList = json['problemDrawingList']
      ..answerDrawingList = json['answerDrawingList'];
  }
}
