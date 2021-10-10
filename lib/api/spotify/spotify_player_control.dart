import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<bool> connectToSpotify() async {
  return SpotifySdk.connectToSpotifyRemote(
      clientId: Globals.CLIENT_ID, redirectUrl: Globals.REDIRECT_URI);
}

playSong(String spotifyURI) {
  try {
    var play = SpotifySdk.play(spotifyUri: spotifyURI);
  } catch (err) {
    print(err);
  }
}
