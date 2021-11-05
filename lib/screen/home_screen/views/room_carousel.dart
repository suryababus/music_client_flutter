import 'dart:math';
import 'dart:ui';

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
                physics: const PageScrollPhysics(),
                controller: PageController(
                  viewportFraction: 0.6,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                    child: Container(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Center(
                            child: AnimatedContainer(
                              clipBehavior: Clip.hardEdge,
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    roomController.selectedRoomIndex == index
                                        ? 0
                                        : 15.0,
                              ),
                              child: Image.network(
                                rooms[index].songSpotifyImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          // Positioned(
                          //   bottom: 0,
                          //   left: 0,
                          //   right: 0,
                          //   child: Center(
                          //     child: new ClipRect(
                          //       child: new BackdropFilter(
                          //         filter: new ImageFilter.blur(
                          //             sigmaX: 2.0, sigmaY: 2.0),
                          //         child: new Container(
                          //           padding: EdgeInsets.symmetric(vertical: 15),
                          //           decoration: new BoxDecoration(
                          //               color: Colors.black.withOpacity(0.4)),
                          //           child: new Center(
                          //             child: new Text(
                          //               rooms[index].name,
                          //               style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.w700,
                          //                 letterSpacing: 1,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.thumb_up_off_alt_outlined,
                  color: Colors.blue.withOpacity(0.8),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
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
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/room');
                    },
                    icon: Icon(
                      Icons.play_circle,
                      color: Colors.blue.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
