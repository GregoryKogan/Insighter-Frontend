import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class NewUserSpan extends StatelessWidget {
  NewUserSpan({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  void goRegister() {
    stateController.setAuthView('sign_up');
    stateController.setErrorString('');
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'New user? ',
          style:
              TextStyle(color: context.theme.extension<Palette>()!.foreground)),
      TextSpan(
          text: 'SIGN UP',
          style: TextStyle(
            color: context.theme.extension<Palette>()!.orange,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()..onTap = goRegister)
    ]));
  }
}
