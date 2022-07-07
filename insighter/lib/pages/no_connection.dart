import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insighter/theming/themes.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  void _tryAgain() {
    Get.offNamed('/loading');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.extension<Palette>()!.background,
      child: SafeArea(
        child: Scaffold(
            body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.wifi_off, size: 85.0),
            const Text("Could not connect to the server"),
            TextButton(
              onPressed: _tryAgain,
              style: TextButton.styleFrom(
                primary: context.theme.extension<Palette>()!.magenta,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(fontSize: 15),
              ),
              child: const Text("Try again"),
            )
          ]),
        )),
      ),
    );
  }
}
