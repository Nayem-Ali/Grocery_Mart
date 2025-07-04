import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  static void success({required String message, int duration = 3}) {
    BotToast.showText(
      text: message,
      contentColor: Colors.greenAccent,
      duration: Duration(seconds: duration),
    );
  }

  static void failure({required String message, int duration = 3}) {
    BotToast.showText(
      text: message,
      contentColor: Colors.redAccent,
      duration: Duration(seconds: duration),
    );
  }
}
