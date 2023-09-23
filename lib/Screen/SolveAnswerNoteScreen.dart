import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/SerializedXFile.dart';
import 'package:student_app/Controller/SolveAnswerNoteController.dart';

class SolveAnswerNote extends StatelessWidget {
  const SolveAnswerNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      GetX<SolveAnswerNoteController>(builder: (controller) {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "문제",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: FittedBox(
                                child: Text(
                                  '${controller.minutes.value}:${controller.seconds.value.toString().padLeft(2, '0')}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: DrawingBoard(
                            key: Key(controller.index.value.toString()),
                            controller: DrawingController(),
                            background: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.white,
                            ),
                            showDefaultActions: false,
                            showDefaultTools: false,
                          )),
                      _buildNote(
                        controller.note[controller.index.value],
                        context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      })
    ]);
  }

  Padding _buildNote(dynamic problem, BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < problem.questions.length; i++) {
      if (problem.questions[i] is String) {
        children.add(Text(
          problem.questions[i],
          style: const TextStyle(fontSize: 30),
        ));
      } else if (problem.questions[i] is SerializableXFile) {
        children.add(problem.questions[i]);
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
