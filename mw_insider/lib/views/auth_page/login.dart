import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/themes.dart';
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
      color: context.theme.extension<Palette>()!.background,
      child: SafeArea(
        child: Scaffold(
          body: ScrollableView(
            child: Column(children: [
              SizedBox(height: context.height / 10),
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
              const SizedBox(height: 10),
              ErrorMessage(),
              const SizedBox(height: 10),
              LoginButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
