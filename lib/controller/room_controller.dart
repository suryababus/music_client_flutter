import 'dart:async';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/api/socio_music/response/get_rooms.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/controller/socket_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class RoomController extends GetxController {
  bool loading = true;
  List<Room> rooms = [];
  List<Song> songs = [];
  String joinedRoom = "";
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
    Get.offAllNamed('/home');
    update();
    SpotifySdk.subscribeConnectionStatus().listen((event) {
      print('connection event');
      print(event);
    });
  }

  void joinRoom(String roomId) async {
    if (joinedRoom == roomId) return;
    joinedRoom = roomId;
    var resp = await getRoom(roomId);
    songs = resp.data.songs;
    SpotifySdk.pause();
    socketController?.connectToRoom(roomId);
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
    var resp = await getRoom(joinedRoom);
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
