import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';

import 'add_song_modal.dart';

class MusicTabView extends StatefulWidget {
  MusicTabView({
    Key? key,
  }) : super(key: key);

  @override
  _MusicTabViewState createState() => _MusicTabViewState();
}

class _MusicTabViewState extends State<MusicTabView>
    with AutomaticKeepAliveClientMixin<MusicTabView> {
  RoomController roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    void showAddSongModal() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black.withOpacity(0.8),
        builder: (context) {
          return AddSongModal();
        },
        isScrollControlled: true,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        GetBuilder<RoomController>(builder: (roomController) {
          return ListView.builder(
              itemCount: roomController.songs.length,
              itemBuilder: (_, index) {
                return RadioLineItem(song: roomController.songs[index]);
              });
        }),
        Positioned(
          bottom: 5,
          child: Center(
            child: Container(
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0XFFC3A137).withOpacity(0.9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                onPressed: showAddSongModal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      'Add Song',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RadioLineItem extends StatelessWidget {
  RadioLineItem({
    Key? key,
    required this.song,
  }) : super(key: key);
  final Song song;
  RoomController roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      child: Row(
        children: [
          Image.network(
            song.imageUrlMedium,
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.name,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Added By: ' + song.addedByUserName,
                    style: TextStyle(color: Colors.white.withOpacity(0.3)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  var success = await reactToSong(
                      roomController.rooms[roomController.selectedRoomIndex].id,
                      song.id,
                      'like');
                  if (success) roomController.refreshRoomSongs();
                },
                child: Row(
                  children: [
                    Icon(
                      song.reaction == 'like'
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: Colors.green,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        song.likes.toString(),
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  var success = await reactToSong(
                      roomController.rooms[roomController.selectedRoomIndex].id,
                      song.id,
                      'dislike');
                  if (success) roomController.refreshRoomSongs();
                },
                child: Row(
                  children: [
                    Icon(
                      song.reaction == 'dislike'
                          ? Icons.thumb_down_alt
                          : Icons.thumb_down_alt_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        song.dislikes.toString(),
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
