import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Icon(Icons.wifi_off, size: 100.0),
        Text("Could not connect to server"),
        Text(
          "Try again later",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ]),
    ));
  }
}
