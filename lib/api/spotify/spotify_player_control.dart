import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<bool> connectToSpotify() async {
  var state = await SpotifySdk.subscribeConnectionStatus();
  state.listen((event) {
    var errorMessage = event.message;
    if (errorMessage != null) {
      Get.snackbar(
        "SocioMusic",
        errorMessage,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        instantInit: false,
      );
      return;
    }

    if (!event.connected) {
      SpotifySdk.connectToSpotifyRemote(
          clientId: Globals.CLIENT_ID, redirectUrl: Globals.REDIRECT_URI);
    }
  });
  return SpotifySdk.connectToSpotifyRemote(
      clientId: Globals.CLIENT_ID, redirectUrl: Globals.REDIRECT_URI);
}

Future<bool> playSong(String spotifyURI) async {
  try {
    return await SpotifySdk.play(spotifyUri: spotifyURI);
  } catch (err) {
    print(err);
  }
  return false;
}
