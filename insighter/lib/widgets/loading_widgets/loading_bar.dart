import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/theming/themes.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            backgroundColor: context.theme.extension<Palette>()!.comment,
            valueColor: AlwaysStoppedAnimation<Color>(
                context.theme.extension<Palette>()!.magenta!),
          ),
          const SizedBox(height: 10),
          const Text('Loading'),
        ],
      ),
    );
  }
}
