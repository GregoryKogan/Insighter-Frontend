import 'package:flutter/material.dart';

class Stroll extends StatelessWidget {
  const Stroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stroll page'),
      ),
      body: const Center(child: Text('Stroll page')),
    );
  }
}
