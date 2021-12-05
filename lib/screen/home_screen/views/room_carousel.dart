import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/controller/room_controller.dart';

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
    return Container(
        height: 250,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Trending",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: rooms.length * 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    index = (index % 2);
                    return GestureDetector(
                      onTap: () {
                        print(rooms[index].id);
                        roomController.joinRoom(rooms[index].id);
                        Get.toNamed("/room");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 180,
                        height: 250,
                        child: Stack(
                          children: [
                            Image.network(
                              rooms[index].songSpotifyImage,
                              fit: BoxFit.cover,
                              width: 180,
                              height: 250,
                            ),
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment
                                      .bottomCenter, // 10% of the width, so there are ten blinds.
                                  colors: <Color>[
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                    Colors.black,
                                  ],
                                  stops: [0, 0.4, 1],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: Icon(
                                              Icons
                                                  .supervised_user_circle_rounded,
                                              size: 24,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            "4000",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          rooms[index].name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
