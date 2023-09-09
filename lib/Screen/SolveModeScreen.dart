import 'package:flutter/material.dart';
import 'package:student_app/Component/Problem.dart';

class SolveScreen extends StatelessWidget {
  SolveScreen({super.key, required this.problem, required this.index});

  int index;
  final Problem problem;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
            child: Text(
              "$index번 문제",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        //수정할 부분, 문제 부분 추가하고 풀이부분, 타이머 등 추가해야함
        body: SafeArea(child: Container()),
      )
    ]);
  }
}
