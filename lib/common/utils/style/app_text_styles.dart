import 'package:crewmeister_test/common/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static final TextStyle title = TextStyle(
    color: AppColors.colors.titleText,
    fontWeight: FontWeight.bold,
    fontSize: 36,
  );

  static final TextStyle subTitle = TextStyle(
    color: AppColors.colors.titleText,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );


  static final TextStyle headings = TextStyle(
    color: AppColors.colors.secondaryText,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static final TextStyle headingsSemiBold = TextStyle(
    color: AppColors.colors.secondaryText,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static final TextStyle headingsBold = TextStyle(
    color: AppColors.colors.titleText,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static final TextStyle medium = TextStyle(
    color: AppColors.colors.approvedTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  static final TextStyle mediumBold = TextStyle(
    color: AppColors.colors.approvedColor,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
}
