import 'package:daelim_project/routes/app_screen.dart';
import 'package:daelim_project/screens/login/login_screen.dart';
import 'package:daelim_project/screens/main/main_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppScreen.login.toPath,
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
      builder: (context, state) => const MainScreen(),
    ),
  ],
);
