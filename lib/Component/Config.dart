import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const double outPadding = 2.0;
const String HOST = 'ec2-3-36-65-242.ap-northeast-2.compute.amazonaws.com:3000';

//118.36.177.117 스터디라운지
//175.124.93.223 원격연결

enum httpContentType {
  json,
  multipart,
}

/// Return header of http Request
///
/// Argument: httpContentType(json, multipart...)
Future<Map<String, String>> defaultHeader(httpContentType type) async {
  Map<String, String> header = await sendCookieToBackend();
  if (type == httpContentType.json) {
    header.addAll({"Content-type": "application/json"});
  } else if (type == httpContentType.multipart) {
    //header.addAll({"Content-type": "multipart/form-data"});
  }
  return header;
}

/// if http request is success, response.statusCode will be 2xx
///
/// return true when request is success
bool isHttpRequestSuccess(response) {
  return response.statusCode ~/ 100 == 2;
}

/// [!isHttpRequestSuccess]
bool isHttpRequestFailure(response) {
  return !isHttpRequestSuccess(response);
}

///저장된 쿠키를 읽고 Map<String,String>형식으로 담아 header로 쓸 수 있게 반환하는 메소드
Future<Map<String, String>> sendCookieToBackend() async {
  const storage = FlutterSecureStorage();
  final uid = await storage.read(key: 'uid');
  final accessToken = await storage.read(key: 'access_token');
  final refreshToken = await storage.read(key: 'refresh_token');

  Map<String, String> header = {
    "cookie": "access_token=$accessToken; refresh_token=$refreshToken; uid=$uid",
  };
  return header;
}
