import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Controller/TotalController.dart';

class ProblemTimer extends StatefulWidget {
  ProblemTimer({super.key, required this.problem, required this.refresh});

  Problem problem;
  bool refresh;

  @override
  State<ProblemTimer> createState() => ProblemTimerState();
}

class ProblemTimerState extends State<ProblemTimer> {
  late Timer timer;
  bool isActive = false;

  @override
  void initState() {
    debugPrint("initiate timer");
    super.initState();
    if (widget.problem.isSolved.value == false) {
      startTimer();
      isActive = true;
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (widget.problem.isSolved.value == true) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          if (widget.problem.seconds < 59) {
            widget.problem.seconds++;
          } else {
            widget.problem.minutes++;
            widget.problem.seconds = 0;
          }
        });
      }
      Get.find<TotalController>().HomeWorks.refresh();
    });
  }

  @override
  void dispose() {
    if (isActive) {
      timer.cancel();
    }
    debugPrint("timer disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        '시간 ${widget.problem.minutes}:${widget.problem.seconds.toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
