import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mw_insider/pages/main_page.dart';
import 'package:mw_insider/pages/unknown_route.dart';
import 'package:mw_insider/theming/theme_service.dart';
import 'package:mw_insider/theming/themes.dart';

void main() async {
  await GetStorage.init();
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
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
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
