import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/color_service.dart';
import 'package:mw_insider/theming/themes.dart';

class LoginInput extends StatelessWidget {
  LoginInput({Key? key}) : super(key: key);
  final stateController = Get.put(StateController());

  _onChanged(String val) {
    stateController.updateUserLogin(val);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: SizedBox(
        height: 60,
        child: TextField(
          onChanged: _onChanged,
          cursorColor: context.theme.extension<Palette>()!.green,
          enableSuggestions: true,
          autocorrect: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorService.soften(
                context.theme.extension<Palette>()!.background!, context.theme,
                amount: 0.05),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                color: context.theme.extension<Palette>()!.comment!,
              ),
            ),
            labelText: 'Username',
            labelStyle: TextStyle(
                color: ColorService.soften(
                    context.theme.extension<Palette>()!.comment!, context.theme,
                    amount: 0.2)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusColor: context.theme.extension<Palette>()!.orange,
            prefixIcon: Icon(
              Icons.person,
              color: context.theme.extension<Palette>()!.foreground,
            ),
          ),
        ),
      ),
    );
  }
}
