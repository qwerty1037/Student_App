import 'package:get/get.dart';

class StopwatchModel {
  final String hour;
  final String minute;
  final String seconds;
  final String milliseconds;
  const StopwatchModel({
    required this.hour,
    required this.minute,
    required this.seconds,
    required this.milliseconds,
  });

  factory StopwatchModel.empty() => const StopwatchModel(
        hour: "00",
        minute: "00",
        seconds: "00",
        milliseconds: "00",
      );
}
