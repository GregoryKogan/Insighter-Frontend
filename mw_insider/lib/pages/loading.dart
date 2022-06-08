import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/jwt.dart';
import 'package:mw_insider/api/ping.dart';
import 'dart:async';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';

Future<String> isReadyToUse() async {
  JwtService jwt = JwtService();
  PingService pingService = PingService();
  if (!await pingService.ping()) return 'no connection';

  if (!await jwt.isLoggedIn() || !await jwt.isRefreshable()) {
    await jwt.getNewTokens();
  }

  if (await jwt.isLoggedIn() && await jwt.isRefreshable()) return 'ok';
  return 'not logged in';
}

void validateResponse(String readyToUse) {
  Future.delayed(Duration.zero, () {
    if (readyToUse == 'ok') {
      Get.offNamed('/');
    } else if (readyToUse == 'not logged in') {
      Get.offNamed('/auth');
    } else {
      Get.offNamed('/no_connection');
    }
  });
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Future<String> readyToUse;

  @override
  void initState() {
    super.initState();
    readyToUse = isReadyToUse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Center(
              child: FutureBuilder<String>(
            future: readyToUse,
            builder: (context, snapshot) {
              if (snapshot.hasData) validateResponse(snapshot.data!);
              return const LoadingCircle();
            },
          )),
        ),
      ),
    );
  }
}
