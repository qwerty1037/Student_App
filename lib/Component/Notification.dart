import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:student_app/Component/Problem.dart';
import 'Download.dart';

class NotificationController extends GetxController {
  //메시징 서비스 기본 객체 생성
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async {
    debugPrint("NotificationController");
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    debugPrint("${settings.authorizationStatus}");
    _getToken();
    _onMessage();
    super.onInit();
  }

  void _getToken() async {
    String? token = await messaging.getToken();
    try {
      debugPrint(token);
    } catch (e) {}
  }

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _onMessage() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        Get.to(Downloader());
        /*
        debugPrint(
            'onDidReceiveNotificationResponse - payload: ${details.payload}');
        final payload = details.payload ?? '';
        final parsedJson = jsonDecode(payload);
        if (!parsedJson.containsKey('routeTo')) {
          return;
        }
        Get.toNamed(parsedJson['routeTo']);
        */
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.max,
            ),
          ),
        );
      }

      debugPrint('foreground 상황에서 메시지를 받았다.');

      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification!.body}');
      }

      if (message.data != null) {
        String _title = message.data['title'];
        DateTime _deadline = DateTime.parse(message.data['deadline']);
        String _teacherName = message.data['teacherName'];
        //List<Problem> problems = [];
        //message.data["problems"][]
        debugPrint("title: $_title");
        debugPrint("deadline: $_deadline");
        debugPrint("teacherName; $_teacherName");
      }
    });

    // Background 상태. Notification 서랍에서 메시지 터치하여 앱으로 돌아왔을 때의 동작은 여기서.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage rm) {
      Get.to(Downloader());
    });

    // Terminated 상태에서 도착한 메시지에 대한 처리
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Get.to(Downloader());
    }
  }
}
