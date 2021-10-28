import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';

class RoomCarousel extends StatefulWidget {
  const RoomCarousel({Key? key}) : super(key: key);
  @override
  _RoomCarouselState createState() => _RoomCarouselState();
}

class _RoomCarouselState extends State<RoomCarousel> {
  var rnd = new Random();
  RoomController roomController = Get.find<RoomController>();
  @override
  Widget build(BuildContext context) {
    final List<Room> rooms = roomController.rooms;
    return Center(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: PageView.builder(
                onPageChanged: roomController.updateSelectedRoom,
                itemCount: rooms.length,
                controller: PageController(viewportFraction: 0.5),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.network(
                      rooms[index].songSpotifyImage,
                      height: 100,
                    ),
                  );
                }),
          ),
          Container(
            width: 200,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xde4A4040),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Text(
                rooms[roomController.selectedRoomIndex].name,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
