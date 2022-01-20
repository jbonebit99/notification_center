import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('notification_center');

class MethodChannelNotification {
  MethodChannelNotification() : super() {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Completer completer = Completer();

  static setHandler() {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'receiverNotification':
        if (call.arguments != null) {
         return completer.complete(call.arguments);
        }
        return completer.complete();

      default:
        return completer.complete();
    }
  }

  Future<dynamic> getData() async {
    // setHandler();
    return completer.future;
  }
}
