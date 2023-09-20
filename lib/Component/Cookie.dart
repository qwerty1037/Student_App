import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///쿠키를 안전한 보관소에 저장하는 함수
Future<void> saveCookieToSecureStorage(String uid, String accessToken, String refreshToken) async {
  var storage = const FlutterSecureStorage();
  await storage.write(key: 'uid', value: uid);
  await storage.write(key: 'access_token', value: accessToken);
  await storage.write(key: 'refresh_token', value: refreshToken);
}

///쿠키 headder와 cookieName을 파라미터로 받아 이름에 해당하는 내용을 추출하는 함수
String? getCookieValue(String cookieHeader, String cookieName) {
  if (cookieHeader.isNotEmpty) {
    List<String> cookies = cookieHeader.split(RegExp(r';|,'));
    for (String cookie in cookies) {
      cookie = cookie.trim();
      if (cookie.startsWith('$cookieName=')) {
        return cookie.substring(cookieName.length + 1);
      }
    }
  }
  return null;
}
