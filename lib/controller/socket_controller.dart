import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:sociomusic/api/Auth.dart';
import 'package:sociomusic/api/socio_music/response/get_room.dart';
import 'package:sociomusic/controller/message_controller.dart';
import 'package:sociomusic/controller/player_controller.dart';
import 'package:sociomusic/controller/room_controller.dart';
import 'package:sociomusic/spotify.config.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketController extends GetxController {
  String? connectedRoomId;
  WebSocketChannel? channel;
  late RoomController roomController;
  late PlayerController playerControl;
  late MessageController messageController;
  bool isPaused = false;
  bool isReconnecting = false;
  SocketController(RoomController _roomController,
      PlayerController _playerControl, MessageController _messageController) {
    roomController = _roomController;
    playerControl = _playerControl;
    messageController = _messageController;
    const oneSec = Duration(seconds: 5);

    Timer.periodic(oneSec, (Timer t) {
      print('pinging');
      send('ping');
    });
    connect();
  }

  void connectToRoom(String roomId) {
    if (roomId == connectedRoomId) return;
    connectedRoomId = roomId;
    _connectToRoom();
  }

  void _connectToRoom() {
    if (connectedRoomId == null) return;
    send("join_room", data: connectedRoomId);
  }

  void connect() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse(Globals.SOCIO_MUSIC_SOCKET_DOMAIN),
      );
      StreamSubscription<dynamic>? subScription;
      subScription = channel?.stream.listen(
        (event) {
          print("event");
          print(event);
          handleSocketEvents(event);
        },
        onDone: () {
          subScription?.cancel();
          reConnect();
          print('ws channel closed');
        },
        onError: (err) {
          print("ws channel error");
        },
      );
    } catch (err) {
      print('websocket error');
      print(err);
    }
  }

  void reConnect() async {
    isReconnecting = true;
    print("reconnecting socket");
    update();
    await Future.delayed(Duration(seconds: 5));
    connect();
  }

  void handleSocketEvents(event) async {
    handleSocketEventsMessage(event);
    try {
      var json = jsonDecode(event) as Map<String, dynamic>;
      var action = json["action"];
      var data = json["data"];
      switch (action) {
        case 'connected':
          {
            isReconnecting = false;
            _connectToRoom();
            update();
          }
          break;
        case 'song_added':
          {
            roomController.addSong(new Song.fromJson(json["data"]));
          }
          break;
        case 'reaction':
          {
            print(data);
            roomController.refreshRoomSongs();
          }
          break;
        case 'sync':
          {
            var songs = data['songs'] ?? [];
            if (songs.length == 0) {
              SpotifySdk.pause();
            }
            roomController.replaceSong(
                List.from(songs).map((e) => Song.fromJson(e)).toList());
          }
          break;
        case 'ping':
          {
            print("Received ping");
          }
          break;
        case 'play_song':
          {
            var currentSong = Song.fromJson(data['currentSong']);
            print('play_song');
            print(data);
            var startedMillis = data['startedMillis'];
            var currentMillis = data['currentMillis'];
            playerControl.playSongAndSync(
                currentSong.spotifyUri, currentMillis - startedMillis);
          }
          break;
        case 'stop_song':
          {
            SpotifySdk.pause();
          }
          break;
        default:
          {
            print('unhandled action ${json["action"]}');
          }
      }
    } on Exception catch (e) {
      print("handleSocketEvents err");
      print(e);
    }
  }

  void handleSocketEventsMessage(event) async {
    try {
      var json = jsonDecode(event) as Map<String, dynamic>;
      var action = json["action"];
      var data = json["data"];
      switch (action) {
        case 'connected':
          {
            update();
          }
          break;
        case 'song_added':
          {
            var song = new Song.fromJson(json["data"]);
            messageController.addMessage(Message(
                MessageType.INFO,
                "${song.addedByUserName} added ${song.name} by ${song.artistName}",
                ""));
          }
          break;
        case 'reaction':
          {
            print(data["user_name"]);
            messageController.addMessage(Message(
                MessageType.INFO,
                "${data["user_name"]} ${data["reaction"]}d ${data["song_name"]}",
                data["user_name"]));
          }
          break;
        case 'text_message':
          {
            messageController.addMessage(Message(
                MessageType.OWN_Message, data["message"], data["user_name"]));
          }
          break;

        default:
          {
            print('unhandled action ${json["action"]}');
          }
      }
    } on Exception catch (e) {
      print("handleSocketEvents err");
      print(e);
    }
  }

  void syncRoom() async {
    send('sync');
  }

  void play() {
    isPaused = false;
    syncRoom();
  }

  void pause() {
    SpotifySdk.pause();
    isPaused = true;
  }

  void send(String event, {String? data}) async {
    channel?.sink.add(jsonEncode({
      "event": event,
      "data": data ?? '',
      "token": await SocioMusicAuth.getToken(),
    }));
  }
}
