import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:student_app/Screen/SolveModeScreen.dart';

class ProblemList extends StatelessWidget {
  ProblemList({super.key, required this.problems, required this.title});

  List<Problem> problems;
  String title;

  List<GestureDetector> _buildProblems(BuildContext context) {
    if (problems.isEmpty) {
      return const <GestureDetector>[];
    }

    return problems.map((problem) {
      return GestureDetector(
        onTap: () {
          Get.to(() => SolveScreen(problem: problem, index: problems.indexOf(problem)));
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
                      style: problem.isSolved ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                  ),
                ),
                Text(
                  "걸린 시간 ${problem.time.inMinutes}분",
                  style: problem.isSolved ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 14),
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
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          body: SafeArea(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(outPadding),
              childAspectRatio: 1.0,
              children: _buildProblems(context),
            ),
          ),
        )
      ],
    );
  }
}
