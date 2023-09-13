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
  bool isActive = false;


  @override
  void initState() {
    super.initState();
    if (widget.problem.isSolved == false) {
      startTimer();
      isActive = true;
    }
    
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (widget.problem.isSolved == true) {
          timer.cancel();
        }
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
    if (isActive) {
      timer.cancel();
    }
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
