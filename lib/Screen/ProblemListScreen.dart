import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Controller/SolveModeController.dart';
import 'package:student_app/Screen/SolveModeScreen.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key});

  List<Problem> problems = Get.arguments["problems"];
  String title = Get.arguments["title"];

  List<GestureDetector> _buildProblems(BuildContext context) {
    if (problems.isEmpty) {
      return const <GestureDetector>[];
    }

    return problems.map((problem) {
      return GestureDetector(
        onTap: () {
          Get.to(() => const SolveScreen(), binding: BindingsBuilder(() {
            Get.put(SolveModeController(problems.indexOf(problem), problems));
          }));
        },
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(outPadding),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: FittedBox(
                    child: Text(
                      "${problems.indexOf(problem) + 1}번 문제",
                      style: problem.isSolved
                          ? const TextStyle(color: Colors.grey)
                          : TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                    ),
                  ),
                ),
                Text(
                  "걸린 시간 ${problem.minutes}분 ${problem.seconds}초",
                  style: problem.isSolved
                      ? const TextStyle(color: Colors.grey)
                      : TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      );
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
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
