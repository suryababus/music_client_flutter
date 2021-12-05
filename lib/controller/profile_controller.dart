import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/login_response.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/controller/room_controller.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import 'message_controller.dart';
import 'player_controller.dart';
import 'socket_controller.dart';

void handleErr(err) {
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
}

class ProfileController extends GetxController {
  bool loggedIn = false;
  User? user;
  @override
  void onReady() async {
    // called after the widget is rendered on screen
    bool connected = false;
    try {
      connected = await connectToSpotify();
    } on PlatformException catch (err) {
      print(err);

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
    user = await SocioMusicAuth.authenticate();
    if (user == null) {
      return;
    }

    var roomController =
        Get.put<RoomController>(RoomController(), permanent: true);
    var messageController =
        Get.put<MessageController>(MessageController(), permanent: true);
    var playerController =
        Get.put<PlayerController>(PlayerController(), permanent: true);
    var socketController = Get.put<SocketController>(
        SocketController(
            roomController, playerController, messageController, this),
        permanent: true);
    roomController.setSocketController(socketController);
    playerController.socketController = socketController;
    update();
  }
}
