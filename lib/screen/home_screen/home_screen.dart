import 'dart:ui';

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
          title: Image.asset(
            "assets/images/sociomusic.png",
            height: 50,
            width: 150,
          ),
          actions: [
            IconButton(
              onPressed: () {
                print('search pressed');
              },
              icon: Icon(
                Icons.add_box_outlined,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(itemBuilder: (contect, index) {
                  if (index == 0) return OnlineUsers();
                  return RoomCarousel();
                }),
              ),
              PlayerControl()
            ],
          );
        }),
      ),
    );
  }
}

class OnlineUsers extends StatelessWidget {
  const OnlineUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Online",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            "https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Mahes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }
}
