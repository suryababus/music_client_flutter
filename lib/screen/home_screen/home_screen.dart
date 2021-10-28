import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import 'views/room_carousel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RoomController _roomController = Get.find<RoomController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<RoomController>(builder: (controller) {
          return Column(
            children: [
              Flexible(
                flex: 2,
                child: RoomCarousel(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Color(0xC3A137),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/room');
                      },
                      child: Row(
                        children: [
                          Icon(Icons.play_circle),
                          Padding(padding: EdgeInsets.all(2)),
                          Text('Play'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 3,
                child: SongsList(),
              )
            ],
          );
        }),
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  SongsList({Key? key}) : super(key: key);

  RoomController roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    var songs = roomController.songs;
    if (songs.length == 0) {
      return Center(
        child: Text(
          'Nothing Here',
          style: Theme.of(context).textTheme.headline1,
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Songs',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Flexible(
          child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async  {
                    await playSong(songs[index].spotifyUri);
                    Future.delayed(const Duration(milliseconds: 2000), (){
                    SpotifySdk.seekTo(
                positionedMilliseconds: 24000);

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      songs[index].name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
