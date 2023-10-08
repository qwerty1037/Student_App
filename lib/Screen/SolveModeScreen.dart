import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Component/ProblemTimer.dart';
import 'package:student_app/Component/SerializedProblemImage.dart';
import 'package:student_app/Controller/SolveModeController.dart';
import 'package:student_app/Controller/TotalController.dart';

class SolveScreen extends StatelessWidget {
  const SolveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primaryContainer,
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
                    key: Key(controller.index.value.toString() +
                        controller.refreshTimer.value.toString()),
                    problem: controller.problems[controller.index.value],
                    refresh: controller.refreshTimer.value,
                  )
                ],
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                icon: const Icon(Icons.arrow_right),
              ),
            ],
          ),
          //수정할 부분, 문제 부분 추가하고 풀이부분, 타이머 등 추가해야함
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    child: _buildProblem(
                      controller.problems[controller.index.value],
                      context,
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: DrawingBoard(
                      key: Key(controller.index.value.toString()),
                      controller: controller.problems[controller.index.value]
                          .problemDrawingController,
                      background: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.7,
                        color: Colors.white,
                      ),
                      showDefaultActions: true,
                      showDefaultTools: true,
                    ),
                  ),
                  /*
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.problems[controller.index.value].save();
                        },
                        child: Text("저장하기"),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.problems[controller.index.value].load();
                        },
                        child: Text("불러오기"),
                      ),
                    ],
                  ),
                  */
                  Row(
                    children: [
                      Text(
                        "답: ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: DrawingBoard(
                              key: Key(controller.index.value.toString()),
                              controller: controller
                                  .problems[controller.index.value]
                                  .answerDrawingController,
                              background: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                color: Colors.white,
                              ),
                              showDefaultActions: false,
                              showDefaultTools: false,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.problems[controller.index.value]
                                .answerDrawingController
                                .clear();
                          },
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(height: 10),
                  //저장 버튼
                  Visibility(
                    visible: controller
                            .problems[controller.index.value].isSolved.value ==
                        false,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.problems[controller.index.value].isSolved
                            .value = true;
                        controller.incrementIndex(context);
                        Get.find<TotalController>()
                            .homeWorks[controller.homeWorkIndex]
                            .checkFinished();
                      },
                      child: const Text("풀이 완료하기"),
                    ),
                  ),
                  Visibility(
                    visible:
                        controller.problems[controller.index.value].isSolved ==
                            true,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.problems[controller.index.value].isSolved
                            .value = false;
                        controller.restartTimer();
                      },
                      child: const Text("풀이 수정하기"),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      } else if (problem.questions[i] is SerializableProblemImage) {
        children.add(Image.file(
          File(problem.questions[i].path),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
        ));
      } else {
        debugPrint("questions이 이미지나 text형태가 아님");
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
