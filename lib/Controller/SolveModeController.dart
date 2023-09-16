import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';

class SolveModeController extends GetxController {
  RxInt index = 0.obs;
  List<Problem> problems = [];
  RxBool refreshTimer = false.obs;

  void restartTimer() {
    if (refreshTimer.value == false) {
      refreshTimer.value = true;
    } else {
      refreshTimer.value = false;
    }
  }

  final firstSnackBar = const SnackBar(
    content: Center(child: Text('첫번째 문제입니다')),
  );
  final lastSnackBar = const SnackBar(
    content: Center(child: Text('마지막 문제입니다')),
  );

  SolveModeController(int _index, List<Problem> _problems) {
    index.value = _index;
    problems = _problems;
  }

  void incrementIndex(BuildContext context) {
    if (index.value < problems.length - 1) {
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
