import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:crewmeister_test/module/attendance/ui/widgets/circular_container.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8.0,
        ),
        child: CircularContainer(
          radius: 10,
          bgColor: AppColors.colors.primaryColor,
          borderColor: AppColors.colors.background,
          child: Icon(
            Icons.filter_alt,
            color: AppColors.colors.background,
          ),
        ),
      ),
    );
  }
}
