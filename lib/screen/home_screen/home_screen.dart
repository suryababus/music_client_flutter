import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';
import 'package:sociomusic/screen/room_screen/views/player_control.dart';

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
        appBar: AppBar(
          title: Text("HOME"),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.notifications_active,
            color: Colors.blue.withOpacity(0.8),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.settings,
                color: Colors.blue.withOpacity(0.8),
              ),
            )
          ],
        ),
        body: GetBuilder<RoomController>(builder: (controller) {
          return Column(
            children: [
              Flexible(
                flex: 3,
                child: RoomCarousel(),
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
        Expanded(
          child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    songs[index].name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                );
              }),
        ),
        PlayerControl()
      ],
    );
  }
}
