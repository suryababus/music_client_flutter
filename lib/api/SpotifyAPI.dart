import 'dart:convert';

import 'package:http/http.dart' as http;
import 'Auth.dart';

class SpotifyWeb {
  static Future<dynamic> getRecentPlayed() async {
    var response = await http.get(
        Uri.parse("https://api.spotify.com/v1/me/player/recently-played"),
        headers: {"Authorization": "Bearer " + await SpotifyAuth.getToken()});
    return json.decode(response.body);
  }
}
