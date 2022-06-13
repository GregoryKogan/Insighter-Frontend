import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/authorization.dart';
import 'package:mw_insider/theming/themes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  void _onPressed() {
    AuthorizationService auth = AuthorizationService();
    auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(130, 40),
        backgroundColor:
            context.theme.extension<Palette>()!.red!.withOpacity(0.1),
        primary: context.theme.extension<Palette>()!.red!,
        side: BorderSide(
          color: context.theme.extension<Palette>()!.red!,
          width: 1,
        ),
        shape: const StadiumBorder(),
      ),
      child: const Text("Log out"),
    );
  }
}
