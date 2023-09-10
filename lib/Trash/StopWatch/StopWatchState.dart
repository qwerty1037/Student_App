import 'dart:async';

import 'package:get/get.dart';
import 'package:student_app/StopWatch/StopwatchModel.dart';

class StopwatchState extends GetxController {
  Timer? timer;
  int count = 0;
  var stopwatch = Rxn<StopwatchModel>();
  StopwatchState({super.key}) {
    stopwatch.value = StopwatchModel.empty();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      stopwatch.value = StopwatchModel(
        hour: ((count ~/ (60000 * 6))) > 9
            ? ((count ~/ (60000 * 6))).toString()
            : "0${((count ~/ (60000 * 6)))}",
        minute: ((count ~/ 6000) % 60) > 9
            ? ((count ~/ 6000) % 60).toString()
            : "0${((count ~/ 6000) % 60)}",
        seconds: ((count ~/ 100) % 60) > 9
            ? ((count ~/ 100) % 60).toString()
            : "0${((count ~/ 100) % 60)}",
        milliseconds: ((count % 100).toString().padLeft(2, '0')),
      );
      count = count + 1;
    });
  }

  void stopTimer() {
    timer?.cancel();
  }
}
