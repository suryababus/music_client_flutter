import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/screen/error_screen/error_screen.dart';
import 'package:sociomusic/screen/home_screen/home_screen.dart';
import 'package:sociomusic/screen/home_screen/player_controller.dart';
import 'package:sociomusic/screen/splashScreen.dart';
import 'package:sociomusic/ui/theme/theme.dart';

import 'screen/home_screen/room_controller.dart';
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
  RoomController controller = Get.put<RoomController>(RoomController());

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
        )
      ],
      initialRoute: '/splash',
    );
  }
}
