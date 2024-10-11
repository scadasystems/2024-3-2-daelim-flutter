import 'package:daelim_project/common/scaffold/app_navigation_rail.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final AppScreen appScren;
  final Widget child;
  const AppScaffold({
    super.key,
    required this.appScren,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppNavigationRail(
              appScren: appScren,
            ),
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
