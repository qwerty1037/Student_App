import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/StopWatch/StopWatchState.dart';

class Stopwatch extends StatelessWidget {
  Stopwatch({super.key}) {
    Get.put(StopwatchState());
  }
  var state = Get.find<StopwatchState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Row(
          children: [
            _timeForm(
              content: "${state.stopwatch.value?.minute}",
              width: 100,
              fontSize: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _timeForm(
                content: ":",
                width: null,
                fontSize: 85,
              ),
            ),
            _timeForm(
              content: "${state.stopwatch.value?.seconds}",
              width: 100,
              fontSize: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _timeForm(
                content: ":",
                width: null,
                fontSize: 85,
              ),
            ),
            _timeForm(
              content: "${state.stopwatch.value?.milliseconds}",
              width: 100,
              fontSize: 70,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _timeForm({
    required String content,
    required double? width,
    required double fontSize,
  }) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
