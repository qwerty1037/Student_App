import 'package:flutter/material.dart';
import 'package:student_app/Component/Problem.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../Trash/StopWatch/StopwatchScreen.dart';

class SolveScreen extends StatelessWidget {
  SolveScreen({super.key, required this.problem, required this.index});
  GlobalKey<SfSignaturePadState> _signaturePadStateKey = GlobalKey();

  int index;
  final Problem problem;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: Theme.of(context).colorScheme.primary,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
            child: Text(
              "$index번 문제",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        //수정할 부분, 문제 부분 추가하고 풀이부분, 타이머 등 추가해야함
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "$index번",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    StopwatchScreen(),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: SfSignaturePad(
                    key: _signaturePadStateKey,
                    backgroundColor: Colors.white,
                    minimumStrokeWidth: 4.0,
                    maximumStrokeWidth: 4.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
