// ignore_for_file: unused_element, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:great_places/providers/users.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:great_places/models/user.dart';

FlutterLocalNotificationsPlugin localNotification;
String _newPassword = "";
String _newLogin = "";
List<User> users = [];
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

  void _setNewLoginUState(String username) {
    if (username.length > 0) {
        _newLogin = username;
    }
  }

void _register() {
    User u = new User(_newLogin, _newPassword);
    users.add(u);
    _showNotification(
        "Succesful registration", "You succesfully registered " );
  }

class User {
  Object password;

  User(newLogin, newPassword);

  Object get username => null;
}

  // void _login() {
  //   for (User u in users) {
  //     if (_newLogin == u.username) {
  //       if (_newPassword == u.password) {
  //         _showNotification(
  //             "Log in", "You succesfull loged in ");
  //         setState(() {
  //           _loggedInUser = _newLogin;
  //         });
  //       }
  //     }
  //   }
  //   void _setNewLoginUState(String username) {
  //   if (username.length > 0) {
  //     setState(() {
  //       _newLogin = username;
  //     });
  //   }
  // }

  // void _setNewLoginPState(String password) {
  //   if (password.length > 0) {
  //     setState(() {
  //       _newPassword = password;
  //     });
  //   }
  // }