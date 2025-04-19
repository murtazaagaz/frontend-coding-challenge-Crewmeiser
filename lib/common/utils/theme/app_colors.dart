import 'package:crewmeister_test/common/utils/theme/base_colors.dart';
import 'package:crewmeister_test/common/utils/theme/light_mode_colors.dart';

class AppColors {
  AppColors._();
  static final AppColors _instance = AppColors._();
  factory AppColors() => _instance;

  static BaseColors _colors = LightModeColors();

  static BaseColors get colors => _colors;

  static void changeColorThemeDark() {
    _colors = LightModeColors();
  }

  static void changeColorThemeDefault() {
    _colors = LightModeColors();
  }
}
