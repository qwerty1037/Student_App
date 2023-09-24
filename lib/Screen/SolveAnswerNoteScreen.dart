import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/SerializedProblemImage.dart';
import 'package:student_app/Controller/SolveAnswerNoteController.dart';
import 'package:student_app/Controller/TotalController.dart';

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
                  FittedBox(
                    child: Text(
                      '${controller.minutes.value}:${controller.seconds.value.toString().padLeft(2, '0')}',
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            actions: [
              IconButton(
                  onPressed: () {
                    int index = controller.index.value;
                    Get.back();
                    if (Get.find<TotalController>().answerNote[index] is SerializableProblemImage) {
                      File(Get.find<TotalController>().answerNote[index].path).deleteSync();
                    }
                    Get.find<TotalController>().answerNote.removeAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text("오답노트에서 제거되었습니다")),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_forever)),
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
                  Container(
                    color: Colors.white,
                    child: _buildNote(
                      controller.note[controller.index.value],
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
                        controller: DrawingController(
                          config: DrawConfig(
                            color: Colors.black,
                            contentType: SimpleLine,
                          ),
                        ),
                        background: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          color: Colors.white,
                        ),
                        showDefaultActions: true,
                        showDefaultTools: true,
                      )),
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: DrawingBoard(
                              key: Key("${controller.index.value}-answer"),
                              controller: DrawingController(
                                config: DrawConfig(
                                  color: Colors.black,
                                  contentType: SimpleLine,
                                ),
                              ),
                              background: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              showDefaultActions: false,
                              showDefaultTools: false,
                            ),
                          ),
                        ),
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

  Padding _buildNote(dynamic questions, BuildContext context) {
    List<Widget> children = [];
    if (questions is List<dynamic>) {
      for (int i = 0; i < questions.length; i++) {
        if (questions[i] is String) {
          children.add(Text(
            questions[i],
            style: const TextStyle(fontSize: 30),
          ));
        } else if (questions[i] is SerializableProblemImage) {
          children.add(Image.file(
            File(questions[i].path),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
          ));
        } else {
          debugPrint("이미지나 텍스트가 아님");
        }
      }
    } else if (questions is SerializableProblemImage) {
      children.add(
        Image.file(
          File(questions.path),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
      );
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
