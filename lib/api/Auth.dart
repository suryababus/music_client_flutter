import 'dart:convert';

import 'package:spotify_sdk/spotify_sdk.dart';

import './../spotify.config.dart';
import 'fetch.dart';

class SpotifyAuth {
  static var _token = "";
  static Future<String> getToken() async {
    if (_token != "") return _token;
    var token = await SpotifySdk.getAuthenticationToken(
        clientId: Globals.CLIENT_ID,
        redirectUrl: Globals.REDIRECT_URI,
        scope: Globals.SCOPES.join(","));
    _token = token;
    return token;
  }
}

class SocioMusicAuth {
  static var _token = '';
  static Future<bool> authenticate() async {
    try {
      var response = await dio.post('${Globals.SOCIO_MUSIC_DOMAIN}auth/login',
          data: jsonEncode({"token": await SpotifyAuth.getToken()}));
      print(response.data);
      _token = response.data["data"]["token"];
      return true;
    } on Exception catch (err) {
      print(err);
    }
    return false;
  }

  static Future<String> getToken() async {
    return _token;
  }
}
