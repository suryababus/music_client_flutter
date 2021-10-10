import 'dart:convert';

import 'package:sociomusic/api/fetch.dart';
import 'response/getRooms.dart';
import 'response/getRoom.dart';

Future<GetRoomsResponse> getRooms() async {
  var response = await FetchFromSocioMusic.get('rooms');
  var body = json.decode(response.body);
  return GetRoomsResponse.fromJson(body);
}

Future<GetRoomResponse> getRoom(String roomId) async {
  var response = await FetchFromSocioMusic.get('rooms/' + roomId);
  var body = json.decode(response.body);
  print(body);
  return GetRoomResponse.fromJson(body);
}
