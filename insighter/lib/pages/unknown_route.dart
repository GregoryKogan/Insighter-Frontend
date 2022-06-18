import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/theming/themes.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.extension<Palette>()!.background,
      child: SafeArea(
        child: Scaffold(
          body: Center(
              child: Column(
            children: [
              const Text('Page not found'),
              const Text('404'),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/');
                  },
                  child: const Text('Back'))
            ],
          )),
        ),
      ),
    );
  }
}
