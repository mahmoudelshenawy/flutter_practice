import 'dart:convert';

import 'package:dash/zeus_app/main_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessages(RemoteMessage? message) async {}

class FirebaseApi {
  //intialize firebase messaging instance
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This Channel is something good",
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  //handle intailize notifications
  Future<void> initNotifications() async {
    //request permissions from user
    await _firebaseMessaging.requestPermission();
    //fetch the FCM for device
    final fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);
    initPushNotifications();
    initLocalNotifications();
  }

  //handle received messages
  void hangleMessage(RemoteMessage? message) {
    if (message == null) return;

    //navigate to new screen when message is received
    navigatorKey.currentState?.pushNamed("/notifications", arguments: message);
  }

  Future initLocalNotifications() async {
    // const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        hangleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  //setup foreground and background settings
  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(hangleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(hangleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                //icon
                icon: "@drawable/ic_launcher"),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }
}
