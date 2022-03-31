// ignore_for_file: unused_element

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:great_places/models/user.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


FlutterLocalNotificationsPlugin localNotification;
Future<void> _showNotification(String title, String body) async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Local Notification", "This is the description",
        importance: Importance.max);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, title, body, generalNotificationDetails);
  }
  
String _newExam = "";
String _newPassword = "";
String _newLogin = "";
List<User> users = [];
void _register() {
  User u = new User(_newLogin, _newPassword);
  users.add(u);
  _showNotification(
      "Succesful registration", "You succesfully registered " + u.username);
}
