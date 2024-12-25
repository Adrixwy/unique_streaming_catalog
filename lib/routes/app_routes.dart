import 'package:flutter/material.dart';
import 'package:unique_streaming_catalog/ui/screens/home_screen.dart';
import 'package:unique_streaming_catalog/ui/screens/login_screen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      home: (context) => HomeScreen(),
    };
  }
}
