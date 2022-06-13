import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/themes.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          backgroundColor: context.theme.extension<Palette>()!.comment,
          valueColor: AlwaysStoppedAnimation<Color>(
              context.theme.extension<Palette>()!.magenta!),
        ),
        const SizedBox(height: 20),
        const Text('Loading'),
      ],
    );
  }
}
