import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/widgets/error_message.dart';
import 'package:mw_insider/widgets/log_in_span.dart';
import 'package:mw_insider/widgets/login_input.dart';
import 'package:mw_insider/widgets/password_confirmation_input.dart';
import 'package:mw_insider/widgets/password_input.dart';
import 'package:mw_insider/widgets/signup_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  void goLogin() async {
    stateController.setAuthView('log_in');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        goLogin();
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
            child: Column(children: [
          const Spacer(flex: 6),
          const Text(
            'Sign up',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoginInput(),
          const SizedBox(height: 10),
          PasswordInput(),
          const SizedBox(height: 10),
          PasswordConfirmationInput(),
          const SizedBox(height: 10),
          LoginSpan(),
          const Spacer(flex: 1),
          ErrorMessage(),
          const Spacer(flex: 1),
          SignupButton(),
          const Spacer(flex: 12),
        ])),
      ),
    );
  }
}
