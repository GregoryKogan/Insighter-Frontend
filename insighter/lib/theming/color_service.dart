import 'package:flutter/material.dart';

class ColorService {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color darken(Color color, {double amount = 0.1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static Color lighten(Color color, {double amount = 0.1}) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  static intensify(Color color, ThemeData theme, {double amount = 0.1}) {
    if (theme.brightness == Brightness.light) {
      return lighten(color, amount: amount);
    } else {
      return darken(color, amount: amount);
    }
  }

  static soften(Color color, ThemeData theme, {double amount = 0.1}) {
    if (theme.brightness == Brightness.light) {
      return darken(color, amount: amount);
    } else {
      return lighten(color, amount: amount);
    }
  }
}
