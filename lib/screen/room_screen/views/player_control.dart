import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sociomusic/controller/player_controller.dart';
import 'package:sociomusic/controller/socket_controller.dart';

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
      return Column(
        children: [
          GetBuilder<PlayerController>(builder: (playerController) {
            var playingSongName =
                playerController.playerState?.track?.name ?? "";
            var imagerUri = playerController.playingSongImage;
            var artistName =
                playerController.playerState?.track?.artist.name ?? "";
            var playedPosition = playerController.playedmillis;
            var totalDuriation =
                playerController.playerState?.track?.duration ?? 1;
            var playedPercent = playedPosition / totalDuriation;
            var isPaused = playerController.playerState?.isPaused ?? true;
            if (playingSongName == "") return Container();
            return Column(
              children: [
                LinearProgressIndicator(
                  minHeight: 1,
                  value: playedPercent,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
                ListTile(
                  tileColor: Theme.of(context).appBarTheme.backgroundColor,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
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
                  subtitle: Text(
                    artistName,
                    style: TextStyle(
                        color: Colors.white38,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700),
                  ),
                  horizontalTitleGap: 2,
                  trailing: GestureDetector(
                    onTap: () {
                      if (isPaused) {
                        playerController.play();
                      } else {
                        playerController.pausePlayer();
                      }
                    },
                    child: Icon(
                      isPaused
                          ? Icons.play_circle_rounded
                          : Icons.pause_circle_rounded,
                      size: 60,
                      color: Color(0Xff0177fa).withOpacity(0.95),
                    ),
                  ),
                ),
              ],
            );
          }),
          PersistMessage()
        ],
      );
    } on Exception catch (err) {
      print(err);
      return Container();
    }
  }
}

class PersistMessage extends StatelessWidget {
  const PersistMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocketController>(builder: (socketController) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: double.infinity,
        height: socketController.isReconnecting ? 40 : 0,
        padding: EdgeInsets.all(10),
        color: Colors.red.withOpacity(0.5),
        child: Center(
          child: Text(
            'Reconnecting...',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    });
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
  // scrollController.jumpTo(0);
  // await scrollController.animateTo(600,
  //     duration: Duration(milliseconds: 10000), curve: Curves.linear);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: Text(
        widget.playingSongName,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
