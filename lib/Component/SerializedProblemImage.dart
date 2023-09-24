import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class SerializableProblemImage {
  final String path;

  SerializableProblemImage(this.path);

  String get problemImagePath {
    return path;
  }

  // ProblemImage 객체를 Map으로 직렬화
  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }

  // Map을 ProblemImage 객체로 역직렬화
  factory SerializableProblemImage.fromJson(Map<String, dynamic> json) {
    return SerializableProblemImage(
      json['path'],
    );
  }
}
