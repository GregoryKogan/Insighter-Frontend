import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/state_controllers/state_controller.dart';
import 'package:insighter/views/auth_page/login.dart';
import 'package:insighter/views/auth_page/signup.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final stateController = Get.put(StateController());

  static final views = {
    'log_in': const LoginView(),
    'sign_up': SignUpView(),
  };

  @override
  Widget build(BuildContext context) {
    return Obx((() => views[stateController.authView.value]!));
  }
}
