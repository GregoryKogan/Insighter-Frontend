import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
