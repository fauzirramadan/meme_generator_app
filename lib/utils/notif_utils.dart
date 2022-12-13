import 'package:flutter/material.dart';

import '../main.dart';

class NotificationUtils {
  static void showSnackbar(String message,
      {Color? backgroundColor, SnackBarAction? action}) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        action: action,
        content: Text(message),
      ),
    );
  }
}
