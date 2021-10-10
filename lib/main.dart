import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/SpotifyAPI.dart';
import 'package:sociomusic/api/socio_music/getRooms.dart';
import 'package:sociomusic/api/socio_music/response/getRooms.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/screen/home_screen/home_screen.dart';
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
  Future<GetRoomsResponse>? _rooms = null;
  var imageUrl = '';

  @override
  @mustCallSuper
  void initState() {
    // SpotifySdk.connectToSpotifyRemote(
    //     clientId: Globals.CLIENT_ID, redirectUrl: Globals.REDIRECT_URI);
    // _recentPlayedSongs = SpotifyWeb.getRecentPlayed();
    _rooms = getRooms();
    getSongs();
  }

  void getSongs() async {
    print(await connectToSpotify());
    // print(await SpotifySdk.play(
    // spotifyUri: 'spotify:track:0zsA45R0SQPfqC5TyDOqY8'));
  }

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
            transition: Transition.zoom)
      ],
      initialRoute: '/splash',
    );
  }
}
