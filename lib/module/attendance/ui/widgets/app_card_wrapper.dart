import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppCardWrapper extends StatelessWidget {
  final Widget child;
  const AppCardWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colors.cardBackground,
      shadowColor: AppColors.colors.background,
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: AppColors.colors.strokeNeutral,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
