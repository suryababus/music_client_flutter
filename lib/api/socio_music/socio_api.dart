import 'dart:convert';

import 'package:sociomusic/api/fetch.dart';
import 'response/get_rooms.dart';
import 'response/get_room.dart';

Future<GetRoomsResponse> getRooms() async {
  var response = await FetchFromSocioMusic.get('rooms');
  var body = json.decode(response.body);
  return GetRoomsResponse.fromJson(body);
}

Future<GetRoomResponse> getRoom(String roomId) async {
  var response = await FetchFromSocioMusic.get('rooms/' + roomId);
  var body = json.decode(response.body);
  return GetRoomResponse.fromJson(body);
}

Future<bool> addSongToRoom(String roomId, Map<String, String> data) async {
  var response = await FetchFromSocioMusic.post('rooms/${roomId}/songs', data);
  var body = (response?.data);
  print(body);
  return body["status"] == 200;
}

Future<bool> reactToSong(String roomId, String songId, String action) async {
  var response = await FetchFromSocioMusic.post(
      'reaction/${roomId}/${songId}', {"action": action});
  print(response);
  return response!.data['status'] == 200;
}
