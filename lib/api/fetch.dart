import 'dart:convert';

import 'package:http/http.dart' as http;
import 'Auth.dart';

class FetchFromSocioMusic {
  static var SocioDomain = 'http://192.168.0.2:3000/';
  static Future<http.Response> get(String url) async {
    var response = await http.get(
      Uri.parse(SocioDomain + url),
      headers: {
        "token": await SocioMusicAuth.getToken(),
      },
    );
    return response;
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> data) async {
    var response = await http.post(Uri.parse(SocioDomain + url),
        headers: {
          "token": await SocioMusicAuth.getToken(),
        },
        body: json.encode(data));
    return response;
  }
}
