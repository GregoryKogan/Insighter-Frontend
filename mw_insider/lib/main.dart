import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mw_insider/pages/main_page.dart';
import 'package:mw_insider/pages/unknown_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MW Insider',
      initialRoute: '/',
      unknownRoute:
          GetPage(name: '/not_found', page: () => const UnknownRoutePage()),
      getPages: [
        GetPage(
            name: '/',
            page: () => MainPage(),
            transition: Transition.noTransition),
      ],
    );
  }
}
