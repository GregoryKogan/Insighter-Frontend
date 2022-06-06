import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/configuration/config.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mw_insider/widgets/loading_circle.dart';

Future<String> pingServer() async {
  final response = await http.get(Uri.parse('${backendUrl}ping'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<void> validateResponse(String response) async {
  if (response != '') Get.offNamed('/');
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Future<String> serverResponse;

  @override
  void initState() {
    super.initState();
    serverResponse = pingServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<String>(
        future: serverResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) validateResponse(snapshot.data!);
          return const LoadingCircle();
        },
      )),
    );
  }
}
