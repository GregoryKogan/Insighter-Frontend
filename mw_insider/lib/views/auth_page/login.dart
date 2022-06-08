import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/widgets/auth_page/error_message.dart';
import 'package:mw_insider/widgets/auth_page/login_input.dart';
import 'package:mw_insider/widgets/auth_page/login_view/login_button.dart';
import 'package:mw_insider/widgets/auth_page/login_view/new_user_span.dart';
import 'package:mw_insider/widgets/auth_page/password_input.dart';
import 'package:mw_insider/widgets/wrappers/scrollable_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: ScrollableView(
            minHeight: 400.0,
            screenHeightFactor: 1.0,
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Spacer(flex: 6),
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              LoginInput(),
              const SizedBox(height: 10),
              PasswordInput(),
              const SizedBox(height: 10),
              NewUserSpan(),
              const Spacer(flex: 1),
              ErrorMessage(),
              const Spacer(flex: 1),
              LoginButton(),
              const Spacer(flex: 12),
            ])),
          ),
        ),
      ),
    );
  }
}
