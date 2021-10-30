import 'dart:async';
import 'dart:typed_data';

import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayerController extends GetxController {
  PlayerState? playerState;
  Future<Uint8List?>? playingSongImage;
  var playedmillis = 0;
  @override
  void onReady() async {
    var state = await SpotifySdk.subscribePlayerState();
    state.listen((event) {
      playerState = event;
      var imageUri = playerState?.track?.imageUri;
      if(imageUri != null){
      playingSongImage =
          SpotifySdk.getImage(imageUri: imageUri);
      }
      playedmillis = event.playbackPosition.milliseconds.inMilliseconds;
      update();
    });
    _startPlayerSyncker();
  }

  void _startPlayerSyncker() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      if (playerState == null) return;
      if (playerState?.isPaused ?? true) return;
      playedmillis = playedmillis + 1000;
      update();
    });
    super.onReady();
  }
}
