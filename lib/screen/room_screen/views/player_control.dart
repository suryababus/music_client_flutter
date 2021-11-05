import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sociomusic/screen/home_screen/player_controller.dart';
import 'package:sociomusic/screen/home_screen/socket_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

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

  var socketController = Get.find<SocketController>();
  @override
  Widget build(BuildContext context) {
    try {
      return GetBuilder<PlayerController>(builder: (playerState) {
        var playingSongName = playerState.playerState?.track?.name ?? "";
        var imagerUri = playerState.playingSongImage;
        var artistName = playerState.playerState?.track?.artist.name ?? "";
        var playedPosition = playerState.playedmillis;
        var totalDuriation = playerState.playerState?.track?.duration ?? 1;
        var playedPercent = playedPosition / totalDuriation;
        var isPaused = playerState.playerState?.isPaused ?? true;
        if (playingSongName == "") return Container();
        return ListTile(
          leading: Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder<Uint8List?>(
                future: imagerUri,
                builder: (context, snapshot) {
                  print('called');
                  if (snapshot.hasData) {
                    var image = snapshot.data;
                    if (image != null) {
                      return Image.memory(image);
                    }
                  }
                  return CircularProgressIndicator();
                }),
          ),
          title: AutoScrollText(playingSongName: playingSongName),
          horizontalTitleGap: 2,
          subtitle: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: LinearProgressIndicator(
              value: playedPercent,
              backgroundColor: Colors.white.withOpacity(0.2),
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              if (isPaused) {
                socketController.play();
              } else {
                socketController.pause();
              }
            },
            child: Icon(
              isPaused ? Icons.play_circle_rounded : Icons.pause_circle_rounded,
              size: 60,
              color: Colors.blue.withOpacity(0.8).withOpacity(0.95),
            ),
          ),
        );
      });
    } on Exception catch (err) {
      print(err);
      return Container();
    }
  }
}

class AutoScrollText extends StatefulWidget {
  AutoScrollText({
    Key? key,
    required this.playingSongName,
  }) : super(key: key);
  final String playingSongName;

  @override
  State<AutoScrollText> createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText> {
  var start = 0.0, end = 1.0;

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: Text(
        widget.playingSongName,
        style: TextStyle(color: Colors.white, fontSize: 24),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
