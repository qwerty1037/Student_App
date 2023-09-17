import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Controller/SolveModeController.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/SolveModeScreen.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});
  int homeWorkIndex = Get.arguments["HomeWorkIndex"];
  List<Problem> problems = Get.find<TotalController>().HomeWorks[Get.arguments["HomeWorkIndex"]].problems;
  String title = Get.find<TotalController>().HomeWorks[Get.arguments["HomeWorkIndex"]].title;

  List<GestureDetector> _buildProblems(BuildContext context) {
    if (problems.isEmpty) {
      return const <GestureDetector>[];
    }

    return problems.map((problem) {
      int problemIndex = problems.indexOf(problem);
      return GestureDetector(onTap: () {
        Get.to(() => SolveScreen(), binding: BindingsBuilder(() {
          Get.put(SolveModeController(problems.indexOf(problem), problems, homeWorkIndex));
        }));
      }, child: GetX<TotalController>(
        builder: (controller) {
          return Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(outPadding),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        "${problemIndex + 1}번 문제",
                        style:
                            problem.isSolved.value ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ),
                  Text(
                    "걸린 시간 ${controller.HomeWorks[homeWorkIndex].problems[problemIndex].minutes}분 ${controller.HomeWorks[homeWorkIndex].problems[problemIndex].seconds}초",
                    style: problem.isSolved.value
                        ? const TextStyle(color: Colors.grey)
                        : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Text(
                title,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          body: SafeArea(
            child: GridView.count(
              crossAxisCount: 1,
              padding: const EdgeInsets.all(outPadding),
              childAspectRatio: 10,
              children: _buildProblems(context),
            ),
          ),
        )
      ],
    );
  }
}
