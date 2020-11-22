import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class FlutterNotifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static getNotificationInitialization() {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOs =
        IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }

  static void flutterAlarm() {
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'News',
        'Breaking News updated :)',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        // tz.TZDateTime.now(tz.local).add(Duration(milliseconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // static Future onSelectNotification(String payload) async {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return Body(
  //       payload: payload,
  //     );
  //   }));
  // }
}
