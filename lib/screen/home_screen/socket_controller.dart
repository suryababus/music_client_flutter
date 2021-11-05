import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketController extends GetxController {
  String? connectedRoomId;
  WebSocketChannel? channel;
  late RoomController roomController;
  bool isPaused = false;
  SocketController(RoomController _roomController) {
    roomController = _roomController;
    connect();
  }

  void connectToRoom(String roomId) {
    if (roomId == connectedRoomId) return;
    connectedRoomId = roomId;
    send("join_room", data: roomId);
  }

  void connect() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(Globals.SOCIO_MUSIC_SOCKET_DOMAIN),
      );
      channel?.stream.listen((event) {
        print("event");
        print(event);
        handleSocketEvents(event);
      });
      print('websocket connected');
      const oneSec = Duration(seconds: 60);
      Timer.periodic(oneSec, (Timer t) {
        print('pinging');
        send('ping');
      });
    } catch (err) {
      print('websocket error');
      print(err);
    }
  }

  void handleSocketEvents(event) async {
    try {
      var json = jsonDecode(event) as Map<String, dynamic>;
      var action = json["action"];
      var data = json["data"];
      switch (action) {
        case 'song_added':
          {
            roomController.addSong(new Song.fromJson(json["data"]));
          }
          break;
        case 'reaction':
          {
            print(data);
            roomController.refreshRoomSongs();
          }
          break;
        case 'sync':
          {
            var songs = data['songs'];
            roomController.replaceSong(
                List.from(songs ?? []).map((e) => Song.fromJson(e)).toList());
          }
          break;
        case 'ping':
          {
            print("Received ping");
          }
          break;
        case 'play_song':
          {
            var currentSong = Song.fromJson(data['currentSong']);
            print(data);
            var startedMillis = data['startedMillis'];
            var currentMillis = data['currentMillis'];
            await playSong(currentSong.spotifyUri);
            if (isPaused) {
              await SpotifySdk.pause();
              return;
            }
            var i = 0;
            while (i < 10) {
              try {
                print("try playing: ${i}");
                await Future.delayed(const Duration(milliseconds: 2000));
                SpotifySdk.seekTo(
                    positionedMilliseconds: currentMillis - startedMillis);
                Get.snackbar(
                  "SocioMusic",
                  "Synced song playback",
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 1),
                  instantInit: false,
                );
                break;
              } catch (err) {
                i++;
                print(err);
              }
            }
          }
          break;
        default:
          {
            print('unhandled action ${json["action"]}');
          }
      }
    } on Exception catch (e) {
      print("handleSocketEvents err");
      print(e);
    }
  }

  void syncRoom() async {
    send('sync');
  }

  void play() {
    isPaused = false;
    syncRoom();
  }

  void pause() {
    SpotifySdk.pause();
    isPaused = true;
  }

  void send(String event, {String? data}) async {
    channel?.sink.add(jsonEncode({
      "event": event,
      "data": data ?? '',
      "token": await SocioMusicAuth.getToken(),
    }));
  }
}
