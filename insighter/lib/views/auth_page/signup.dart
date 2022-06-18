import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/state_controllers/state_controller.dart';
import 'package:insighter/theming/themes.dart';
import 'package:insighter/widgets/auth_page/error_message.dart';
import 'package:insighter/widgets/auth_page/login_input.dart';
import 'package:insighter/widgets/auth_page/password_confirmation_input.dart';
import 'package:insighter/widgets/auth_page/password_input.dart';
import 'package:insighter/widgets/auth_page/signup_view/log_in_span.dart';
import 'package:insighter/widgets/wrappers/scrollable_view.dart';
import 'package:insighter/widgets/auth_page/signup_view/signup_button.dart';

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
      child: Container(
        color: context.theme.extension<Palette>()!.background,
        child: SafeArea(
          child: Scaffold(
            body: ScrollableView(
              child: Center(
                  child: Column(children: [
                SizedBox(height: context.height / 10),
                const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                LoginInput(),
                const PasswordInput(),
                const PasswordConfirmationInput(),
                const SizedBox(height: 10),
                LoginSpan(),
                const SizedBox(height: 10),
                ErrorMessage(),
                const SizedBox(height: 10),
                SignupButton(),
              ])),
            ),
          ),
        ),
      ),
    );
  }
}
