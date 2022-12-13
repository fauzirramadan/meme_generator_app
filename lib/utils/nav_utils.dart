import 'package:flutter/material.dart';

import '../main.dart';

class Nav {
  static Future<dynamic> to(Widget page) async {
    return await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  static Future<dynamic> toAll(Widget page) async {
    return await navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
      (_) => false,
    );
  }

  static Future<dynamic> replace(Widget page) async {
    return await navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
    );
  }

  static Future<dynamic> back({dynamic data}) async {
    return navigatorKey.currentState?.pop(data);
  }
}
