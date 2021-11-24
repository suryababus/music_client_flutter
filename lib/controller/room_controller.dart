import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/controller/message_controller.dart';
import 'package:sociomusic/controller/socket_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

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

  void setSocketController(SocketController _socketController) {
    socketController = _socketController;
  }

  @override
  void onReady() async {
    var response = await getRooms();

    rooms = response.data;
    loading = false;
    print("loaded");
    Get.offNamed('/home');
    await refreshRoomSongs();
    update();
    SpotifySdk.subscribeConnectionStatus().listen((event) {
      print('connection event');
      print(event);
    });
  }

  void joinRoom() {
    socketController?.connectToRoom(rooms[selectedRoomIndex].id);
  }

  void updateSelectedRoom(int index) async {
    print(index);
    _roomSongsCatch[rooms[selectedRoomIndex].id] = songs;
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
