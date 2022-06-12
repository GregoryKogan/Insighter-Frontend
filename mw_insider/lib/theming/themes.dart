import 'package:flutter/material.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.textColor,
    required this.errorColor,
    required this.successColor,
    required this.secondaryColor,
  });

  final Color? textColor;
  final Color? errorColor;
  final Color? successColor;
  final Color? secondaryColor;

  @override
  ThemeExtension<MyColors> copyWith(
      {Color? textColor,
      Color? errorColor,
      Color? successColor,
      Color? secondaryColor}) {
    return MyColors(
      textColor: textColor ?? this.textColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      textColor: Color.lerp(textColor, other.textColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
    );
  }
}

class Themes {
  static final light = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const MyColors(
        textColor: Color(0xff343b58),
        errorColor: Color(0xff8c4351),
        successColor: Color(0xff33635c),
        secondaryColor: Color(0xff34548a),
      ),
    ],
    scaffoldBackgroundColor: const Color(0xffd5d6db),
    canvasColor: const Color(0xffd5d6db),
    primaryColor: const Color(0xff965027),
    disabledColor: const Color(0xff9699a3),
    toggleableActiveColor: const Color(0xff33635c),
    iconTheme: const IconThemeData(
      color: Color(0xff343b58),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xff9699a3),
      circularTrackColor: Color(0xff8f5e15),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff343b58),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: const Color(0xff343b58),
          displayColor: const Color(0xff343b58),
        ),
  );
  static final dark = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const MyColors(
        textColor: Color(0xffc0caf5),
        errorColor: Color(0xfff7768e),
        successColor: Color(0xff73daca),
        secondaryColor: Color(0xff7aa2f7),
      ),
    ],
    scaffoldBackgroundColor: const Color(0xff1a1b26),
    canvasColor: const Color(0xff24283b),
    primaryColor: const Color(0xffff9e64),
    disabledColor: const Color(0xff565f89),
    toggleableActiveColor: const Color(0xff73daca),
    iconTheme: const IconThemeData(
      color: Color(0xffc0caf5),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xff565f89),
      circularTrackColor: Color(0xffe0af68),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff414868),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: const Color(0xffc0caf5),
          displayColor: const Color(0xffc0caf5),
        ),
  );
}
