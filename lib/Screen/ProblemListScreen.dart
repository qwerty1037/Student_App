import 'package:flutter/material.dart';
import 'package:student_app/Component/Config.dart';
import 'package:student_app/Component/HomeDrawer.dart';
import 'package:student_app/Component/Homework.dart';
import 'package:student_app/Test/HomeWork_Example.dart';

class HomeWorkListScreen extends StatelessWidget {
  const HomeWorkListScreen({super.key});

  List<GestureDetector> _buildGridCards(BuildContext context) {
    //로컬 스토리지에서 homework 정보 불러오기

    List<HomeWork> HomeWorks = ExampleHomeWork;
    if (HomeWorks.isEmpty) {
      return const <GestureDetector>[];
    }

    final ThemeData theme = Theme.of(context);
    // final NumberFormat formatter = NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString());

    return HomeWorks.map((HomeWork) {
      return GestureDetector(
        onTap: () {
          debugPrint("${HomeWork.title} 눌림");
          //문제 리스트 페이지로 넘어갈 부분
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Text(
                  HomeWork.title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Text("${HomeWork.teacherName} 선생님"),
              Text("${HomeWork.deadLine.month}월 ${HomeWork.deadLine.day}까지")
            ],
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
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(outPadding),
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(outPadding),
              childAspectRatio: 1.0,
              children: _buildGridCards(context),
            ),
          ),
        ),
      )
    ]);
  }
}
