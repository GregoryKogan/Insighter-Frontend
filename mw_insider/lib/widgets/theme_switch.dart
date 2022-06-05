import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/theme_service.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkMode = Get.isDarkMode;

  void _changeTheme(bool val) {
    setState(() {
      _isDarkMode = val;
    });
    ThemeService().switchTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: _isDarkMode,
          onChanged: _changeTheme,
        ),
        _isDarkMode
            ? const Text('Switch to light theme')
            : const Text('Switch to dark theme'),
      ],
    );
  }
}
