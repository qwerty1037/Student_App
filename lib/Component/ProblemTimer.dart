import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';

class ProblemTimer extends StatefulWidget {
  ProblemTimer({super.key, required this.problem});

  Problem problem;

  @override
  State<ProblemTimer> createState() => ProblemTimerState();
}

class ProblemTimerState extends State<ProblemTimer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (widget.problem.seconds < 59) {
          widget.problem.seconds++;
        } else {
          widget.problem.minutes++;
          widget.problem.seconds = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        '시간 ${widget.problem.minutes}:${widget.problem.seconds.toString().padLeft(2, '0')}',
      ),
    );
  }
}
