import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:insighter/geolocation/geofencing.dart';
import 'package:insighter/pages/auth.dart';
import 'package:insighter/pages/loading.dart';
import 'package:insighter/pages/main_page.dart';
import 'package:insighter/pages/no_connection.dart';
import 'package:insighter/pages/unknown_route.dart';
import 'package:insighter/state_controllers/location_controller.dart';
import 'package:insighter/theming/theme_service.dart';
import 'package:insighter/theming/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final locationController = Get.put(LocationController());
  final geofencingService = GeofencingService();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final permission = await Geolocator.checkPermission();
      locationController.setLocationPermission(permission);
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        geofencingService.fetchLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insighter',
      initialRoute: '/loading',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      unknownRoute:
          GetPage(name: '/not_found', page: () => const UnknownRoutePage()),
      getPages: [
        GetPage(
            name: '/',
            page: () => const MainPage(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/loading',
            page: () => const LoadingPage(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/auth',
            page: () => AuthPage(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/no_connection',
            page: () => const NoConnectionPage(),
            transition: Transition.fadeIn),
      ],
    );
  }
}
