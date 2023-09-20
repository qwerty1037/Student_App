import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/HomeDrawer.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Controller/TotalController.dart';
import 'package:student_app/Screen/ProblemListScreen.dart';
import 'package:student_app/Test/HomeWork_Example.dart';

class HomeWorkListScreen extends StatelessWidget {
  const HomeWorkListScreen({super.key});

  List<GestureDetector> _buildHomeWork(BuildContext context) {
    List<HomeWork> HomeWorks = Get.find<TotalController>().HomeWorks;
    if (HomeWorks.isEmpty) {
      return const <GestureDetector>[];
    }

    return HomeWorks.map((HomeWork) {
      return GestureDetector(
        onTap: () {
          Get.to(() => ProblemList(), arguments: {"HomeWorkIndex": HomeWorks.indexOf(HomeWork)});
        },
        child: GetX<TotalController>(
          builder: (controller) => Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(cardPadding),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        HomeWork.title,
                        style: HomeWork.isFinish.value ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ),
                  Text(
                    "${HomeWork.teacherName} 선생님",
                    style: HomeWork.isFinish.value ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 14),
                  ),
                  Text(
                    "${HomeWork.deadLine.month}월 ${HomeWork.deadLine.day}일",
                    style: HomeWork.isFinish.value ? const TextStyle(color: Colors.grey) : TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 14),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.white10,
            Colors.white10,
            Colors.black12,
            Colors.black12,
            Colors.black12,
          ]),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
            child: Text(
              "과제",
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
            children: _buildHomeWork(context),
          ),
        ),
      )
    ]);
  }
}
