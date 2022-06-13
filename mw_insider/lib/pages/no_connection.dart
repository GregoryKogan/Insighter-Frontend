import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/theming/themes.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.extension<Palette>()!.background,
      child: SafeArea(
        child: Scaffold(
            body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wifi_off, size: 100.0),
                Text("Could not connect to server"),
                Text(
                  "Try again later",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
        )),
      ),
    );
  }
}
