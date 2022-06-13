import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/api/geo_objects/geo_sync_service.dart';
import 'package:mw_insider/api/jwt.dart';
import 'package:mw_insider/api/ping.dart';
import 'package:mw_insider/theming/themes.dart';
import 'dart:async';
import 'package:mw_insider/widgets/loading_widgets/loading_circle.dart';

Future<void> initApp() async {
  final GeoSyncService geoSyncService = GeoSyncService();
  if (geoSyncService.isSyncNecessary()) {
    await geoSyncService.syncGeoObjects();
  }

  final JwtService jwt = JwtService();
  if (!await jwt.isLoggedIn() || !await jwt.isRefreshable()) {
    await jwt.getNewTokens();
  }

  return;
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

void isReadyToUse() async {
  await initApp();

  final PingService pingService = PingService();
  if (!await pingService.ping()) {
    validateResponse('no connection');
    return;
  }

  final JwtService jwt = JwtService();
  if (await jwt.isLoggedIn() && await jwt.isRefreshable()) {
    validateResponse('ok');
    return;
  }

  validateResponse('not logged in');
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    isReadyToUse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.extension<Palette>()!.background,
      child: const SafeArea(
        child: Scaffold(
          body: Center(
            child: LoadingCircle(),
          ),
        ),
      ),
    );
  }
}
