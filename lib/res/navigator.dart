import 'package:flutter/material.dart';

class NavigatorHelper {
  NavigatorHelper._(); // Private constructor to prevent instantiation.

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigates to a new screen.
  static Future? to(Widget path) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => path));
    }
    return null;
  }

  // Pops all screens until reaching the first screen.
  static void popAll() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  // Replaces the current screen with a new screen.
  static void replaceAll(Widget path) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => path));
    }
  }

  // Pops the current screen.
  static void pop([dynamic data]) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pop(data);
    }
  }
}
