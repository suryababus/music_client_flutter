import 'dart:async';
import 'dart:typed_data';

import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/state_manager.dart';
import 'package:sociomusic/api/spotify/spotify_player_control.dart';
import 'package:sociomusic/controller/socket_controller.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayerController extends GetxController {
  PlayerState? playerState;
  Future<Uint8List?>? playingSongImage;
  ImageUri? imageUri;
  late SocketController socketController;
  bool sync = false;
  int syncMilliseconds = 0;
  var playedmillis = 0;
  var playSongUri = '';
  var paused = false;
  @override
  void onReady() async {
    var state = await SpotifySdk.subscribePlayerState();
    playerState = await SpotifySdk.getPlayerState();
    state.listen((event) async {
      playerState = event;
      if ((playSongUri != event.track?.uri || paused) && !event.isPaused) {
        SpotifySdk.pause();
      } else if (sync) {
        await SpotifySdk.seekTo(positionedMilliseconds: syncMilliseconds);
        sync = false;
      }
      var _imageUri = playerState?.track?.imageUri;
      if (_imageUri != null && imageUri != _imageUri) {
        playingSongImage = SpotifySdk.getImage(imageUri: _imageUri);
        imageUri = _imageUri;
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

  void playSongAndSync(String uri, int _offSet) {
    playSongUri = uri;
    playSong(uri);
    sync = true;
    syncMilliseconds = _offSet;
  }

  void pausePlayer() {
    paused = true;
    SpotifySdk.pause();
  }

  void play() {
    paused = false;
    socketController.play();
  }
}
