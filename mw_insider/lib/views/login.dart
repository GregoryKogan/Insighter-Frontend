import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mw_insider/widgets/error_message.dart';
import 'package:mw_insider/widgets/login_button.dart';
import 'package:mw_insider/widgets/login_input.dart';
import 'package:mw_insider/widgets/new_user_span.dart';
import 'package:mw_insider/widgets/password_input.dart';
import 'package:mw_insider/widgets/scrollable_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
