import 'package:flutter/material.dart';
import 'package:mw_insider/widgets/theme_switch.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Profile page'),
          ThemeSwitch(),
        ],
      )),
    );
  }
}
