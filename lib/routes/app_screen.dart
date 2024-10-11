import 'package:flutter/material.dart';

enum AppScreen { login, main, settings }

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
      case AppScreen.main:
        return '/main';
      case AppScreen.login:
        return '/login';
      case AppScreen.settings:
        return '/settings';
    }
  }

  IconData get getIcon {
    switch (this) {
      case AppScreen.main:
        return Icons.home;
      case AppScreen.settings:
        return Icons.settings;
      default:
        return Icons.face;
    }
  }
}
