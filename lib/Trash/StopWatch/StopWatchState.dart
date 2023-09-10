import 'dart:async';

import 'package:get/get.dart';
import 'package:student_app/Trash/StopWatch/StopwatchModel.dart';

class StopwatchState extends GetxController {
  Timer? timer;
  int count;
  StopwatchModel stopwatch;
  StopwatchState({
    this.timer,
    this.count = 0,
    required this.stopwatch,
  });

  StopwatchState copyWith({
    Timer? timer,
    int? count,
    StopwatchModel? stopwatch,
  }) {
    return StopwatchState(
      timer: timer ?? this.timer,
      count: count ?? this.count,
      stopwatch: stopwatch ?? this.stopwatch,
    );
  }

  @override
  List<Object?> get props => [timer, count, stopwatch];

  Future<void> started() async {
    Timer? _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _listener(count);
    });
    //emit(state.copyWith(timer: _timer));
  }

  void _listener(int count) async {
    stopwatch = StopwatchModel(
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
  }
}
