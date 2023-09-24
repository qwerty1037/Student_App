import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Controller/TotalController.dart';

class SolveAnswerNoteController extends GetxController {
  RxInt index = 0.obs;
  List<dynamic> note = [];
  late Timer timer;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds.value++;

      if (seconds.value == 60) {
        seconds.value = 0;
        minutes++;
      }
    });

    ever(index, (_) {
      seconds.value = 0;
      minutes.value = 0;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  final firstSnackBar = const SnackBar(
    content: Center(child: Text('첫번째 문제입니다')),
  );
  final lastSnackBar = const SnackBar(
    content: Center(child: Text('마지막 문제입니다')),
  );

  SolveAnswerNoteController(int _index, List<dynamic> _note, BuildContext context) {
    index.value = _index;
    note = _note;
  }

  void incrementIndex(BuildContext context) {
    if (index.value < note.length - 1) {
      index.value += 1;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(lastSnackBar);
    }
  }

  void decrementIndex(BuildContext context) {
    if (index.value > 0) {
      index.value -= 1;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(firstSnackBar);
    }
  }
}
