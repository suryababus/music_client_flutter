import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/screen/error_screen/error_screen.dart';
import 'package:sociomusic/screen/home_screen/home_screen.dart';
import 'package:sociomusic/screen/install_spotify/install_spotify.dart';
import 'package:sociomusic/screen/settings/settings_screen.dart';
import 'package:sociomusic/screen/splashScreen.dart';
import 'package:sociomusic/ui/theme/theme.dart';

import 'screen/room_screen/room_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.theme,
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(
            name: '/home',
            page: () => HomeScreen(),
            transition: Transition.zoom),
        GetPage(
            name: '/room',
            page: () => RoomScreen(),
            transition: Transition.cupertino),
        GetPage(
          name: '/error',
          page: () => ErrorScreen(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/installSpotify',
          page: () => InstallSpotifyScreen(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsScreen(),
          transition: Transition.cupertino,
        )
      ],
      initialRoute: '/splash',
    );
  }
}
