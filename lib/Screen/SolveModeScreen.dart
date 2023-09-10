import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Component/ProblemTimer.dart';
import 'package:student_app/Controller/SolveModeController.dart';

class SolveScreen extends StatelessWidget {
  const SolveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: Colors.white
          // Theme.of(context).colorScheme.primary,
          ),
      GetX<SolveModeController>(builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${controller.index.value + 1}번 문제",
                  ),
                  ProblemTimer(
                      problem: controller.problems[controller.index.value])
                ],
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            actions: [
              IconButton(
                onPressed: () {
                  controller.decrementIndex(context);
                },
                icon: const Icon(Icons.arrow_left),
              ),
              IconButton(
                  onPressed: () {
                    controller.incrementIndex(context);
                  },
                  icon: const Icon(Icons.arrow_right))
            ],
          ),
          //수정할 부분, 문제 부분 추가하고 풀이부분, 타이머 등 추가해야함
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProblem(
                    controller.problems[controller.index.value], context),
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: DrawingBoard(
                      controller: DrawingController(
                          config: DrawConfig(
                              color: Colors.black, contentType: SimpleLine)),
                      background: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                      ),
                      showDefaultActions: true,
                      showDefaultTools: true,
                    )),
                //저장 버튼
              ],
            ),
          )),
        );
      })
    ]);
  }

  Padding _buildProblem(Problem problem, BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < problem.questions.length; i++) {
      if (problem.questions[i] is String) {
        children.add(Text(
          problem.questions[i],
          style: const TextStyle(fontSize: 30),
        ));
      } else {
        debugPrint("오류");
      }
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
