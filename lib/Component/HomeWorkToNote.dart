import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';

class problemToNote {
  problemToNote({required this.questions});

  List<dynamic> questions;
  Map<String, dynamic> toJson() {
    return {
      'questions': questions,
    };
  }

  factory problemToNote.fromJson(Map<String, dynamic> json) {
    return problemToNote(
      questions: json['questions'],
    );
  }
}
