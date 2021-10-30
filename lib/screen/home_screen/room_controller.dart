import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'player_controller.dart';

class RoomController extends GetxController {
  bool loading = true;
  List<Room> rooms = [];
  List<Song> songs = [];
  int selectedRoomIndex = 0;
  Map<String, List<Song>> _roomSongsCatch = {};
  WebSocketChannel? channel;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    super.onInit();
  }

  @override
  void onReady() async {
    // called after the widget is rendered on screen
    if (await connectToSpotify()) {
      Get.snackbar(
        "SocioMusic",
        "Connected to spotify.",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        instantInit: false,
      );
    } else {
      Get.snackbar(
        "SocioMusic",
        "Error connecting to spotify.",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        instantInit: false,
      );
    }
    if (!await SocioMusicAuth.authenticate()) {
      return;
    }
    Get.put<PlayerController>(PlayerController());

    var response = await getRooms();
    rooms = response.data;
    loading = false;
    print("loaded");
    Get.offNamed('/home');
    await refreshRoomSongs();
    update();
    Get.offNamed('/home');
    connectWS();
  }

  

  void updateSelectedRoom(int index) async {
    print(index);
    selectedRoomIndex = index;
    update();
    if (!_roomSongsCatch.containsKey(rooms[index].id)) {
      var resp = await getRoom(rooms[index].id);
      _roomSongsCatch[rooms[index].id] = resp.data.songs;
    }
    songs = _roomSongsCatch[rooms[index].id]!;
    update();
  }

  void refreshRooms() async {
    loading = true;
    update();
    var response = await getRooms();
    rooms = response.data;
    loading = false;
    update();
  }

  Future<void> refreshRoomSongs() async {
    loading = true;
    update();
    var resp = await getRoom(rooms[selectedRoomIndex].id);
    _roomSongsCatch[rooms[selectedRoomIndex].id] = resp.data.songs;
    songs = resp.data.songs;
    loading = false;
    update();
  }

  void connectWS() {
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
    } catch (err) {
      print('websocket error');
      print(err);
    }
  }

  void joinRoom() async {
    print('join room');
    String roomId = rooms[selectedRoomIndex].id;
    channel?.sink.add(jsonEncode({
      "event": 'join_room',
      "data": roomId,
      "token": await SocioMusicAuth.getToken()
    }));
  }

  void handleSocketEvents(event) async {
    try {
      var json = jsonDecode(event) as Map<String, dynamic>;
      var action = json["action"];
      var data = json["data"];
      switch (action) {
        case 'song_added':
          {
            songs.add(new Song.fromJson(json["data"]));
            update();
          }
          break;
        case 'reaction':
          {
            refreshRoomSongs();
          }
          break;
        case 'sync':
          {
            songs =  List.from(data??[]).map((e) => Song.fromJson(e)).toList();
          }
          break;
        case 'play_song':
          {
            var currentSong = Song.fromJson(data['currentSong']);
            var startedMillis = data['startedMillis'];
            var currentMillis = data['currentMillis'];
            await playSong(currentSong.spotifyUri);
            await SpotifySdk.pause();
            Future.delayed(const Duration(milliseconds: 2000), () {
              SpotifySdk.seekTo(
                  positionedMilliseconds: currentMillis - startedMillis);
            });
            await SpotifySdk.resume();
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

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }
}
