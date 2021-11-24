import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/controller/room_controller.dart';
import 'package:sociomusic/screen/room_screen/views/player_control.dart';

import 'views/room_carousel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          leading: IconButton(
            onPressed: () {
              print('notification pressed');
            },
            icon: Icon(
              Icons.notifications_active,
              color: Color(0Xff0177fa),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                print('search pressed');
              },
              icon: Icon(
                Icons.search_outlined,
                color: Color(0Xff0177fa),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/settings');
              },
              icon: Icon(
                Icons.settings,
                color: Color(0Xff0177fa),
              ),
            )
          ],
        ),
        body: GetBuilder<RoomController>(builder: (controller) {
          return Column(
            children: [
              Container(
                height: 300,
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

class SongsList extends StatefulWidget {
  SongsList({Key? key}) : super(key: key);

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  RoomController roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    var songs = roomController.songs;
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
          child: (songs.length == 0)
              ? Center(
                  child: Text(
                    'Nothing Here',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
              : ListView.builder(
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
                  },
                ),
        ),
        PlayerControl()
      ],
    );
  }
}
