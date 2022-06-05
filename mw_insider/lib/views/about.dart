import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About page'),
        backgroundColor: Colors.indigoAccent[700],
      ),
      body: const Center(child: Text('About page')),
    );
  }
}
