import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/authorization.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class LoginButton extends StatelessWidget {
  LoginButton({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  void _onPressed() {
    stateController.setErrorString('');
    AuthorizationService auth = AuthorizationService();
    auth.login(
        stateController.userLogin.value, stateController.userPassword.value);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(200, 40),
        backgroundColor:
            context.theme.extension<Palette>()!.blue!.withOpacity(0.1),
        primary: context.theme.extension<Palette>()!.blue,
        side: BorderSide(
          color: context.theme.extension<Palette>()!.blue!,
          width: 1,
        ),
        shape: const StadiumBorder(),
      ),
      child: const Text("LOGIN"),
    );
  }
}
