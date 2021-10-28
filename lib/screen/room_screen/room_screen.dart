import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sociomusic/api/spotify/spotify_api.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import 'views/music_tab_item.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    Get.find<RoomController>().joinRoom();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    tabController?.addListener(() {
      //don't remove it
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      leadingWidth: 100,
      bottom: _TabBar(),
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.red[500],
            ),
            Text(
              'Exit',
              style: TextStyle(
                color: Colors.red[500],
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
      title: Text(
        'Radio',
        style: Theme.of(context).textTheme.headline1,
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: tabController, children: [
                MusicTabView(),
                Center(
                  child: Text(
                    'Message',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
              ]),
            ),
            PlayerControl()
          ],
        ),
      ),
    );
  }

  TabBar _TabBar() {
    return new TabBar(controller: tabController, tabs: <Tab>[
      new Tab(
        icon: Icon(
          tabController?.index == 0
              ? Icons.music_note_rounded
              : Icons.music_note_outlined,
          color: tabController?.index == 0 ? Color(0XFFC3A137) : Colors.white,
        ),
      ),
      new Tab(
          icon: Icon(
        tabController?.index == 1
            ? Icons.chat_bubble_rounded
            : Icons.chat_bubble_outline,
        color: tabController?.index == 1 ? Color(0XFFC3A137) : Colors.white,
      )),
    ]);
  }
}

class PlayerControl extends StatefulWidget {
  const PlayerControl({
    Key? key,
  }) : super(key: key);

  @override
  _PlayerControlState createState() => _PlayerControlState();
}

class _PlayerControlState extends State<PlayerControl> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(builder: (controller) {
      try {
        var playingSongName = controller.playerState?.track?.name ?? "";
        var artistName = controller.playerState?.track?.artist.name ?? "";
        var playedPosition = controller.playedmillis;
        var totalDuriation = controller.playerState?.track?.duration ?? 1;
        var playedPercent = playedPosition / totalDuriation;
        var isPaused = controller.playerState?.isPaused ?? true;
        if (playingSongName == "") return Container();
        return SizedBox(
          height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      playingSongName,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        artistName,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: LinearProgressIndicator(
                        value: playedPercent,
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (isPaused) {
                      SpotifySdk.resume();
                    } else {
                      SpotifySdk.pause();
                    }
                  },
                  child: Icon(
                    isPaused
                        ? Icons.play_circle_rounded
                        : Icons.pause_circle_rounded,
                    size: 80,
                    color: Color(0XFFC3A137).withOpacity(0.95),
                  ),
                ),
              )
            ],
          ),
        );
      } catch (err) {
        print(err);
        return Container();
      }
    });
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.white,
    );
  }
}
