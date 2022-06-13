import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/state_controllers/state_controller.dart';
import 'package:mw_insider/theming/color_service.dart';
import 'package:mw_insider/theming/themes.dart';

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
          cursorColor: context.theme.extension<Palette>()!.green,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
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
            labelText: 'Password',
            labelStyle: TextStyle(
                color: ColorService.soften(
                    context.theme.extension<Palette>()!.comment!, context.theme,
                    amount: 0.2)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusColor: context.theme.extension<Palette>()!.orange,
            prefixIcon: Icon(
              Icons.vpn_key,
              color: context.theme.extension<Palette>()!.foreground,
            ),
          ),
        ),
      ),
    );
  }
}
