import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/Trash/StopWatch/StopWatchState.dart';

class StopwatchScreen extends StatelessWidget {
  StopwatchScreen({super.key});
  StopwatchState state = Get.find<StopwatchState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Text("${state.stopwatch.hour}"),
          ],
        ),
      ),
    );
  }
}
