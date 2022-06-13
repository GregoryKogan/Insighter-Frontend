import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class LoginSpan extends StatelessWidget {
  LoginSpan({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  void goLogin() {
    stateController.setAuthView('log_in');
    stateController.setErrorString('');
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Already have an account? ',
          style:
              TextStyle(color: context.theme.extension<Palette>()!.foreground)),
      TextSpan(
          text: 'LOG IN',
          style: TextStyle(
            color: context.theme.extension<Palette>()!.orange,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()..onTap = goLogin)
    ]));
  }
}
