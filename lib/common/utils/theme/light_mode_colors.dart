import 'dart:ui';

import 'package:crewmeister_test/common/utils/theme/base_colors.dart';

class LightModeColors extends BaseColors {
  @override
  Color get approvedColor => Color(0xFFD4F3DD);

  @override
  Color get awaitingColor => Color(0xFFFFF1C4);

  @override
  Color get background => Color(0xFFF8F8FA);

  @override
  Color get cardBackground => Color(0xFFFFFFFF);

  @override
  Color get casualDot => Color(0xFFFFCC00);

  @override
  Color get declinedColor => Color(0xFFFFD9D7);

  @override
  Color get primaryColor => Color(0xFF5D5FEF);

  @override
  Color get secondaryText => Color(0xFF8A8A8A);

  @override
  Color get sickDot => Color(0xFF5D5FEF);

  @override
  Color get titleText => Color(0xFF1D1D4F);

  @override
  Color get approvedTextColor => Color.fromARGB(255, 65, 147, 89);

  @override
  Color get awaitingTextColor => Color.fromARGB(255, 195, 168, 81);

  @override
  Color get declinedTextColor => Color.fromARGB(255, 221, 97, 90);

  @override
  Color get strokeNeutral => Color.fromARGB(255, 220, 220, 220);
}
