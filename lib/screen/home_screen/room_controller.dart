import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/screen/home_screen/socket_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'player_controller.dart';

class RoomController extends GetxController {
  bool loading = true;
  List<Room> rooms = [];
  List<Song> songs = [];
  int selectedRoomIndex = 0;
  Map<String, List<Song>> _roomSongsCatch = {};
  SocketController? socketController;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    super.onInit();
  }

  @override
  void onReady() async {
    // called after the widget is rendered on screen
    bool connected = false;
    try {
      connected = await connectToSpotify();
    } on PlatformException catch (err) {
      print(err);
      if (err.code == 'CouldNotFindSpotifyApp') {
        Get.offNamed('/installSpotify');
      }
      if (err.code == 'NotLoggedInException') {
        Get.offNamed('/error', arguments: {
          'errorTitle': 'Not LoggedIn',
          "errorMessage": 'Please open spotify app and login.'
        });
      } else {
        Get.offNamed('/error',
            arguments: {'errorTitle': err.code, "errorMessage": err.message});
      }
      return;
    } catch (err) {
      Get.offNamed('/error', arguments: {
        'errorTitle': "Connection Error!",
        "errorMessage": "Not connected to spotify"
      });
    }
    if (connected) {
      Get.snackbar(
        "SocioMusic",
        "Connected to spotify.",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        instantInit: false,
      );
      SpotifySdk.pause();
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
    Get.put<PlayerController>(PlayerController(), permanent: true);
    socketController =
        Get.put<SocketController>(SocketController(this), permanent: true);

    var response = await getRooms();

    rooms = response.data;
    loading = false;
    print("loaded");
    Get.offNamed('/home');
    // Get.offNamed('/error', arguments: {
    //   'errorTitle': "Connection Error!",
    //   "errorMessage": "Not connected to internet"
    // });
    await refreshRoomSongs();
    update();
  }

  void joinRoom() {
    socketController?.connectToRoom(rooms[selectedRoomIndex].id);
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

  void addSong(Song song) {
    songs.add(song);
    update();
  }

  void replaceSong(List<Song> _songs) {
    songs = _songs;
    update();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    print('onClose called');
    super.onClose();
  }
}
