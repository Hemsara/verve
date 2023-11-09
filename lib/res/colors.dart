import 'package:flutter/material.dart';

class AppColors {
  static Color neutralColor = HexColor.fromHex("111315");

  static Color gray100 = HexColor.fromHex("828282");
  static Color gray200 = HexColor.fromHex("EEEFF1");

  static Color primary = HexColor.fromHex("25283D");
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceAll('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
