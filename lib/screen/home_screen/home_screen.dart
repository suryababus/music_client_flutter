import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/getRoom.dart';
import 'package:sociomusic/api/socio_music/response/getRooms.dart';
import 'package:sociomusic/api/socio_music/getRooms.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import 'views/room_carousel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<GetRoomsResponse> _rooms;
  Future<GetRoomResponse>? _room;
  var index = 0;
  @override
  void initState() {
    super.initState();
    _rooms = getRooms();
    _rooms.then((value) {
      var roomId = value.data[0].id;
      setState(() {
        _room = getRoom(roomId);
      });
    });
    connectToSpotify();
  }

  void onRoomChange(int pos, String roomId) {
    setState(() {
      index = pos;
      _room = getRoom(roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: RoomCarousel(rooms: _rooms, onRoomChange: onRoomChange),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Color(0xC3A137),
                  child: TextButton(
                    onPressed: () {
                      Get.offNamed('/room');
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
              child: SongsList(room: _room),
            )
          ],
        ),
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  const SongsList({
    Key? key,
    required Future<GetRoomResponse>? room,
  })  : _room = room,
        super(key: key);

  final Future<GetRoomResponse>? _room;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetRoomResponse>(
        future: _room,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var songs = snapshot.data?.data.songs;
            if ((songs?.length ?? 0) == 0) {
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
                      itemCount: songs?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            playSong(songs![index].spotifyUrl);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              songs![index].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        });
  }
}
