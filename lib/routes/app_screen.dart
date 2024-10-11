enum AppScreen { login, main }

extension AppScreenExtension on AppScreen {
  String get toPath {
    switch (this) {
      case AppScreen.login:
        return '/login';
      case AppScreen.main:
        return '/main';
    }
  }
}
