import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';

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
      ],
    );
  }
}
