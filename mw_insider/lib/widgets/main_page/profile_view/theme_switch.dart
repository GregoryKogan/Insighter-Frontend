import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/theme_service.dart';
import 'package:mw_insider/theming/themes.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkMode = Get.isDarkMode;
  late CrossFadeState _crossFadeState;
  double turns = 0.0;
  static const Duration _duration = Duration(milliseconds: 350);
  bool _animationFinished = true;

  @override
  void initState() {
    super.initState();
    _crossFadeState =
        _isDarkMode ? CrossFadeState.showSecond : CrossFadeState.showFirst;
  }

  void _changeRotation() {
    setState(() => turns += 0.5);
  }

  void _changeCrossFadeState() {
    setState(() {
      if (_crossFadeState == CrossFadeState.showFirst) {
        _crossFadeState = CrossFadeState.showSecond;
      } else {
        _crossFadeState = CrossFadeState.showFirst;
      }
    });
  }

  void _changeTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    ThemeService().switchTheme();
  }

  void _onTapped() async {
    if (!_animationFinished) return;
    setState(() => _animationFinished = false);
    _changeRotation();
    _changeCrossFadeState();
    await Future.delayed(_duration);
    _changeTheme();
    _changeRotation();
    await Future.delayed(_duration + const Duration(milliseconds: 10));
    setState(() => _animationFinished = true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedRotation(
          turns: turns,
          duration: _duration,
          curve: Curves.linear,
          child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _onTapped,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedCrossFade(
                  duration: _duration * 2,
                  firstCurve: Curves.easeOutExpo,
                  secondCurve: Curves.easeInExpo,
                  crossFadeState: _crossFadeState,
                  firstChild: const Icon(
                    Icons.light_mode,
                    size: 35,
                  ),
                  secondChild: const Icon(
                    Icons.dark_mode,
                    size: 35,
                  ),
                ),
              )),
        ),
        const SizedBox(width: 10),
        RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: 'Switch to ',
                style: TextStyle(
                    color: context.theme.extension<Palette>()!.foreground)),
            TextSpan(
                text: _isDarkMode ? 'light' : 'dark',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.theme.extension<Palette>()!.foreground)),
            TextSpan(
                text: ' theme',
                style: TextStyle(
                    color: context.theme.extension<Palette>()!.foreground)),
          ],
        )),
      ],
    );
  }
}
