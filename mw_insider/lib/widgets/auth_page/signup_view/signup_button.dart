import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/authorization.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/themes.dart';

class SignupButton extends StatelessWidget {
  SignupButton({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  void _onPressed() {
    stateController.setErrorString('');
    AuthorizationService auth = AuthorizationService();
    if (stateController.userPassword.value !=
        stateController.userPasswordConfirmation.value) {
      stateController.setErrorString('Passwords do not match');
      return;
    }

    auth.signUp(
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
      child: const Text("SIGN UP"),
    );
  }
}
