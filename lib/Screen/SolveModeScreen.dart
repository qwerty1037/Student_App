import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
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
    return GetX<SolveModeController>(builder: (controller) {
      final drawingController = controller.problems[controller.index.value].problemDrawingController;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${controller.index.value + 1}번 문제",
                ),
                ProblemTimer(
                  key: Key(controller.index.value.toString() + controller.refreshTimer.value.toString()),
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    children: [
                      DrawingBoard(
                        onPointerDown: (pde) {
                          if (pde.kind == PointerDeviceKind.touch) {
                            drawingController.endDraw();
                          }
                        },
                        boardBoundaryMargin: EdgeInsets.zero,
                        key: Key(controller.index.value.toString()),
                        controller: drawingController,
                        background: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1.5,
                          color: Colors.white,
                        ),
                        showDefaultActions: true,
                        showDefaultTools: true,
                      ),
                      Positioned(
                        child: _buildProblem(
                          controller.problems[controller.index.value],
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

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
                          controller: controller.problems[controller.index.value].answerDrawingController,
                          background: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.1,
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
                        controller.problems[controller.index.value].answerDrawingController.clear();
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              const SizedBox(height: 10),
              //저장 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: controller.problems[controller.index.value].isSolved.value == false,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.problems[controller.index.value].isSolved.value = true;
                        controller.incrementIndex(context);
                        Get.find<TotalController>().homeWorks[controller.homeWorkIndex].checkFinished();
                      },
                      child: const Text("풀이 완료하기"),
                    ),
                  ),
                  Visibility(
                    visible: controller.problems[controller.index.value].isSolved == true,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.problems[controller.index.value].isSolved.value = false;
                        controller.restartTimer();
                      },
                      child: const Text("풀이 수정하기"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Container _buildProblem(final Problem problem, final BuildContext context) {
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
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
