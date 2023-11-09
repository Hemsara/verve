import 'package:gap/gap.dart';

class AppDimensions {
  static double baseSize = 8;
  static double defaultMargin = 20;

  //button padding
  static double defaultButtonPaddingSmallH = 12;
  static double defaultButtonPaddingMediumH = 16;
  static double defaultButtonPaddingLargeH = 20;

  //button radius
  static double buttonRadiusSmall = 5;
  static double buttonRadiusMedium = 13;
  static double radiusLarge = 45;

  // ==
  static Gap space(int multiplier) => Gap(baseSize * multiplier);
}
