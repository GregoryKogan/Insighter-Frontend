import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  _onChanged(String val) {
    stateController.updateUserPassword(val);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: _onChanged,
          cursorColor: context.theme.primaryColor,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.theme.canvasColor,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                color: context.theme.disabledColor,
              ),
            ),
            labelText: 'Password',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusColor: context.theme.primaryColor,
            prefixIcon: Icon(
              Icons.vpn_key,
              color: context.theme.iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
