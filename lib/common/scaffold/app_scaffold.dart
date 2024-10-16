// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:daelim_project/common/scaffold/app_navigation_rail.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final AppScreen appScreen;
  final Widget child;

  const AppScaffold({
    super.key,
    required this.appScreen,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            AppNavigationRail(appScreen: appScreen),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
