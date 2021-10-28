import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociomusic/api/spotify/response/search_track.dart';

import '../Auth.dart';

class SpotifyWeb {
  static String _accessToken = '';
  static Future<String> getAccessToken() async {
    if (_accessToken == '') {
      _accessToken = await SpotifyAuth.getToken();
    }
    return _accessToken;
  }

  static Future<dynamic> getRecentPlayed() async {
    var response = await http.get(
        Uri.parse("https://api.spotify.com/v1/me/player/recently-played"),
        headers: {"Authorization": "Bearer " + await getAccessToken()});
    return json.decode(response.body);
  }

  static Future<SearchTrackResult> searchTracks(String key) async {
    var response = await http.get(
        Uri.parse(
            "https://api.spotify.com/v1/search?q=${key}&type=track&limit=10"),
        headers: {"Authorization": "Bearer " + await getAccessToken()});
    return SearchTrackResult.fromJson(json.decode(response.body));
  }
}
