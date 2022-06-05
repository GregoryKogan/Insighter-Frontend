import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
        backgroundColor: Colors.indigoAccent[700],
      ),
      body: const Center(child: Text('Profile page')),
    );
  }
}
