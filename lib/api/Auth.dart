import 'package:spotify_sdk/spotify_sdk.dart';

import './../spotify.config.dart';

class SpotifyAuth {
  static Future<String> getToken() async {
    var token = await SpotifySdk.getAuthenticationToken(
        clientId: Globals.CLIENT_ID,
        redirectUrl: Globals.REDIRECT_URI,
        scope: Globals.SCOPES.join(","));
    return token;
  }
}

class SocioMusicAuth {
  static Future<String> getToken() async {
    var token =
        'eyJhbGciOiJIUzI1NiJ9.MzFscGZtdTNnM2M2Z3R0YnBsd3dmNHl4NG91eQ.sM34JpMXHCmOeENxOwWPvVUpT8vOVZCtFhC0gHhlgRQ';
    return token;
  }
}
