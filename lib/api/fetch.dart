import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sociomusic/spotify.config.dart';
import 'Auth.dart';

var dio = Dio();

Future<Options> options() async {
  return new Options(
    headers: {
      "token": await SocioMusicAuth.getToken(),
    },
  );
}

class FetchFromSocioMusic {
  static Future<http.Response> get(String url) async {
    var response = await http.get(
      Uri.parse(Globals.SOCIO_MUSIC_DOMAIN + url),
      headers: {
        "token": await SocioMusicAuth.getToken(),
      },
    );
    return response;
  }

  static Future<Response<dynamic>?> post(
      String url, Map<String, String>? data) async {
    print(data);
    try {
      var response = await dio.post(Globals.SOCIO_MUSIC_DOMAIN + url,
          data: jsonEncode(data), options: await options());
      return response;
    } on Exception catch (err) {
      print(err);
    }
  }
}
