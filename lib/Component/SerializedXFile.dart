import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class SerializableXFile {
  final String path;

  SerializableXFile(this.path);

  // XFile 객체를 Map으로 직렬화
  Map<String, dynamic> toJson() {
    return {
      'path': path,
    };
  }

  // Map을 XFile 객체로 역직렬화
  factory SerializableXFile.fromJson(Map<String, dynamic> json) {
    return SerializableXFile(
      json['path'],
    );
  }

  // XFile 객체를 원래 XFile로 변환
  XFile toXFile() {
    return XFile(path);
  }
}
