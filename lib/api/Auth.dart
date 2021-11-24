import 'dart:convert';

import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/response/login_response.dart';
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
  static Future<User?> authenticate() async {
    try {
      var token = await SpotifyAuth.getToken();
      var response = await dio.post('${Globals.SOCIO_MUSIC_DOMAIN}auth/login',
          data: jsonEncode({"token": token}));

      var loginResponse = LogInResponse.fromJson(response.data);
      _token = loginResponse.data.token;
      return loginResponse.data.user;
    } catch (err) {
      print(err);
      Get.offNamed('/error', arguments: {
        'errorTitle': 'Not Authenticated',
        "errorMessage": 'Ask Surya to add you to early access list.'
      });
    }
    return null;
  }

  static Future<String> getToken() async {
    return _token;
  }
}
