class GetRoomsResponse {
  GetRoomsResponse({
    required this.status,
    required this.data,
  });
  late final int status;
  late final List<Room> data;

  GetRoomsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Room.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Room {
  Room({
    required this.id,
    required this.name,
    required this.songSpotifyUri,
    required this.songSpotifyImage,
    required this.createdTime,
    required this.modifiedTime,
    required this.createdBy,
    required this.modifiedBy,
  });
  late final String id;
  late final String name;
  late final String songSpotifyUri;
  late final String songSpotifyImage;
  late final String createdTime;
  late final String modifiedTime;
  late final CreatedBy createdBy;
  late final ModifiedBy modifiedBy;

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    songSpotifyUri = json['song_spotify_uri'];
    songSpotifyImage = json['song_spotify_image'];
    createdTime = json['created_time'];
    modifiedTime = json['modified_time'];
    createdBy = CreatedBy.fromJson(json['created_by']);
    modifiedBy = ModifiedBy.fromJson(json['modified_by']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['song_spotify_uri'] = songSpotifyUri;
    _data['song_spotify_image'] = songSpotifyImage;
    _data['created_time'] = createdTime;
    _data['modified_time'] = modifiedTime;
    _data['created_by'] = createdBy.toJson();
    _data['modified_by'] = modifiedBy.toJson();
    return _data;
  }
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.name,
    required this.email,
  });
  late final String id;
  late final String name;
  late final String email;

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}

class ModifiedBy {
  ModifiedBy({
    required this.id,
    required this.name,
    required this.email,
  });
  late final String id;
  late final String name;
  late final String email;

  ModifiedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}
