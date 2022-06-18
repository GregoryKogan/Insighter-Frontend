import 'package:flutter/material.dart';
import 'package:insighter/theming/color_service.dart';

class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.background,
    required this.foreground,
    required this.comment,
    required this.red,
    required this.orange,
    required this.yellow,
    required this.green,
    required this.magenta,
    required this.cyan,
    required this.blue,
    required this.black,
  });

  final Color? background;
  final Color? foreground;
  final Color? comment;
  final Color? red;
  final Color? orange;
  final Color? yellow;
  final Color? green;
  final Color? magenta;
  final Color? cyan;
  final Color? blue;
  final Color? black;

  @override
  ThemeExtension<Palette> copyWith(
      {Color? background,
      Color? foreground,
      Color? comment,
      Color? red,
      Color? orange,
      Color? yellow,
      Color? green,
      Color? magenta,
      Color? cyan,
      Color? blue,
      Color? black}) {
    return Palette(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      comment: comment ?? this.comment,
      red: red ?? this.red,
      orange: orange ?? this.orange,
      yellow: yellow ?? this.yellow,
      green: green ?? this.green,
      magenta: magenta ?? this.magenta,
      cyan: cyan ?? this.cyan,
      blue: blue ?? this.blue,
      black: black ?? this.black,
    );
  }

  @override
  ThemeExtension<Palette> lerp(ThemeExtension<Palette>? other, double t) {
    if (other is! Palette) {
      return this;
    }
    return Palette(
      background: Color.lerp(background, other.background, t),
      foreground: Color.lerp(foreground, other.foreground, t),
      comment: Color.lerp(comment, other.comment, t),
      red: Color.lerp(red, other.red, t),
      orange: Color.lerp(orange, other.orange, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      green: Color.lerp(green, other.green, t),
      magenta: Color.lerp(magenta, other.magenta, t),
      cyan: Color.lerp(cyan, other.cyan, t),
      blue: Color.lerp(blue, other.blue, t),
      black: Color.lerp(black, other.black, t),
    );
  }
}

class Themes {
  static final Map<String, dynamic> palette = {
    'dark': {
      'background': '#24283b',
      'foreground': '#c0caf5',
      'comment': '#565f89',
      'red': '#f7768e',
      'orange': '#ff9e64',
      'yellow': '#e0af68',
      'green': '#9ece6a',
      'magenta': '#bb9af7',
      'cyan': '#7dcfff',
      'blue': '#7aa2f7',
      'black': '#414868',
    },
    'light': {
      'background': '#d5d6db',
      'foreground': '#343b58',
      'comment': '#9699a3',
      'red': '#8c4351',
      'orange': '#965027',
      'yellow': '#8f5e15',
      'green': '#33635c',
      'magenta': '#5a4a78',
      'cyan': '#0f4b6e',
      'blue': '#34548a',
      'black': '#0f0f14',
    },
  };

  static Color getColor(String theme, String colorName) {
    return ColorService.fromHex(palette[theme][colorName]);
  }

  static Palette getPalette(String theme) {
    return Palette(
        background: getColor(theme, 'background'),
        foreground: getColor(theme, 'foreground'),
        comment: getColor(theme, 'comment'),
        red: getColor(theme, 'red'),
        orange: getColor(theme, 'orange'),
        yellow: getColor(theme, 'yellow'),
        green: getColor(theme, 'green'),
        magenta: getColor(theme, 'magenta'),
        cyan: getColor(theme, 'cyan'),
        blue: getColor(theme, 'blue'),
        black: getColor(theme, 'black'));
  }

  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[getPalette('light')],
    scaffoldBackgroundColor: getColor('light', 'background'),
    iconTheme: IconThemeData(color: getColor('light', 'foreground')),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: getColor('light', 'foreground'),
          displayColor: getColor('light', 'foreground'),
        ),
  );
  static final dark = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[getPalette('dark')],
    scaffoldBackgroundColor: getColor('dark', 'background'),
    iconTheme: IconThemeData(color: getColor('dark', 'foreground')),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: getColor('dark', 'foreground'),
          displayColor: getColor('dark', 'foreground'),
        ),
  );
}
