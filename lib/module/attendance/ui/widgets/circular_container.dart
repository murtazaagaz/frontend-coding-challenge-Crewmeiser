import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final double size;
  final double radius;
  final Widget child;
  final double? height;
  final double? width;
  const CircularContainer({
    super.key,
    required this.bgColor,
    required this.borderColor,
    this.size = 40,
    this.radius = 80,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? size,
      width: width ?? size,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
