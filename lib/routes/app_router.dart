import 'package:daelim_project/helpers/storage_helper.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:daelim_project/screens/login/login_screen.dart';
import 'package:daelim_project/screens/main/main_screen.dart';
import 'package:daelim_project/screens/setting/setting_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppScreen.login.toPath,
  redirect: (context, state) {
    Log.green(state.fullPath);

    if (state.fullPath == AppScreen.login.toPath) {
      return null;
    }
    if (StorageHelper.authData == null) {
      return AppScreen.login.toPath;
    }
    return null;
  },
  routes: [
    // NOTE: 로그인 화면
    GoRoute(
      path: AppScreen.login.toPath,
      name: AppScreen.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    // NOTE: 메인 화면
    GoRoute(
      path: AppScreen.main.toPath,
      name: AppScreen.main.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MainScreen(),
      ),
    ),
    // NOTE: 실행 확인
    GoRoute(
      path: AppScreen.settings.toPath,
      name: AppScreen.settings.name,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingScreen(),
      ),
    )
  ],
);
