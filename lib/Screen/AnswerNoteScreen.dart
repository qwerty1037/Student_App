import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/SerializedProblemImage.dart';
import 'package:student_app/Controller/SolveAnswerNoteController.dart';
import 'package:student_app/Controller/SolveModeController.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/SolveAnswerNoteScreen.dart';
import 'package:path_provider/path_provider.dart';

class AnswerNote extends StatelessWidget {
  AnswerNote({super.key});
  TotalController totalController = Get.find<TotalController>();

  Future getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final imageName = "${DateTime.now()}.jpg";
      final imagePath = '${appDir.path}/$imageName';
      final Uint8List imageData = await pickedFile.readAsBytes();
      File(imagePath).writeAsBytes(imageData);

      var pickedImage = SerializableProblemImage(imagePath);
      totalController.answerNote.add(pickedImage);
    }
  }

  List<GestureDetector> _buildAnswerNote(BuildContext context, List<dynamic> answerNotes) {
    if (answerNotes.isEmpty) {
      return const <GestureDetector>[];
    }

    return answerNotes.map((answerNote) {
      int answerNoteIndex = answerNotes.indexOf(answerNote);
      return GestureDetector(
          onTap: () {
            Get.to(() => const SolveAnswerNote(), binding: BindingsBuilder(() {
              Get.put(SolveAnswerNoteController(answerNoteIndex, answerNotes, context));
            }));
          },
          child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(outPadding),
              child: Stack(children: [
                Center(
                  child: FittedBox(
                    child: Text(
                      "${answerNoteIndex + 1}번 문제",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Get.find<TotalController>().answerNote.removeAt(answerNoteIndex);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(child: Text("오답노트에서 제거되었습니다")),
                          ),
                        );
                        if (answerNote is SerializableProblemImage) {
                          File(answerNote.path).deleteSync();
                        }
                      },
                      icon: const Icon(Icons.delete)),
                )
              ]),
            ),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "오답노트",
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          actions: [
            IconButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.add_a_photo)),
            IconButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.add_photo_alternate)),
            TextButton(
                onPressed: () {
                  Get.find<TotalController>().answerNote.shuffle();
                },
                child: Text(
                  "순서 MIX",
                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
          ],
        ),
        body: SafeArea(
          //만약 업데이트안되면 여기다가 getxcontroller로 인자 넘겨주는 느낌으로 추가
          child: GetX<TotalController>(builder: (controller) {
            List<dynamic> answerNote = controller.answerNote.reversed.toList();
            return GridView.count(
              crossAxisCount: 1,
              padding: const EdgeInsets.all(outPadding),
              childAspectRatio: 5,
              children: _buildAnswerNote(context, answerNote),
            );
          }),
        ),
      )
    ]);
  }
}
