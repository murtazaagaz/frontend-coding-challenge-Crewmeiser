import 'package:crewmeister_test/common/utils/style/app_text_styles.dart';
import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  final String title;
  final String value;
  const TextInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.mediumBold.copyWith(
            color: AppColors.colors.secondaryText,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          value,
          style: AppTextStyles.medium.copyWith(
            color: AppColors.colors.titleText,
          ),
        )
      ],
    );
  }
}
