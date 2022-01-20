export 'package:notification_center/src/method_channel.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class NotificationCenter {
  static const String _methodRegisterNotificationCenter = "registerNotificationCenter";
  static const String _methodSendNotification = "sendNotification";
  static const String _methodReceiveNotification = "receiveNotification";

  static const MethodChannel _channel = MethodChannel('notification_center');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future registerNotificationCenter() async {
    try {
      return await _channel.invokeMethod(_methodRegisterNotificationCenter);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future sendNotification(Map<String, dynamic> arguments) async {
    try {
      return await _channel.invokeMethod(_methodSendNotification, arguments);
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
