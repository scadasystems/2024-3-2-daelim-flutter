import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final bool reverse;
  final double? width;
  final Color color;

  const GradientDivider({
    super.key,
    this.reverse = false,
    this.width,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            color.withOpacity(0.24),
          ],
          begin: !reverse //
              ? Alignment.centerLeft
              : Alignment.centerRight,
          end: !reverse //
              ? Alignment.centerRight
              : Alignment.centerLeft,
        ),
      ),
    );
  }
}
