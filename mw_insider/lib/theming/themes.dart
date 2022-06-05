import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xffd5d6db),
    canvasColor: const Color(0xffd5d6db),
    primaryColor: const Color(0xff965027),
    disabledColor: const Color(0xff9699a3),
    toggleableActiveColor: const Color(0xff33635c),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff343b58),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff1a1b26),
    canvasColor: const Color(0xff24283b),
    primaryColor: const Color(0xffff9e64),
    disabledColor: const Color(0xff565f89),
    toggleableActiveColor: const Color(0xff73daca),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff414868),
    ),
  );
}
