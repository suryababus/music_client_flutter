class GetRoomResponse {
  GetRoomResponse({
    required this.status,
    required this.data,
  });
  late final int status;
  late final Data data;

  GetRoomResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.createdTime,
    required this.modifiedTime,
    required this.createdBy,
    required this.modifiedBy,
    required this.songs,
  });
  late final String id;
  late final String name;
  late final String createdTime;
  late final String modifiedTime;
  late final CreatedBy createdBy;
  late final ModifiedBy modifiedBy;
  late final List<Songs> songs;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdTime = json['created_time'];
    modifiedTime = json['modified_time'];
    createdBy = CreatedBy.fromJson(json['created_by']);
    modifiedBy = ModifiedBy.fromJson(json['modified_by']);
    songs = List.from(json['songs']).map((e) => Songs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['created_time'] = createdTime;
    _data['modified_time'] = modifiedTime;
    _data['created_by'] = createdBy.toJson();
    _data['modified_by'] = modifiedBy.toJson();
    _data['songs'] = songs.map((e) => e.toJson()).toList();
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

class Songs {
  Songs({
    required this.id,
    required this.spotifyUrl,
    required this.name,
    required this.likes,
    required this.dislikes,
    required this.addedTime,
  });
  late final String id;
  late final String spotifyUrl;
  late final String name;
  late final int likes;
  late final int dislikes;
  late final String addedTime;

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spotifyUrl = json['spotify_url'];
    name = json['name'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    addedTime = json['added_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['spotify_url'] = spotifyUrl;
    _data['name'] = name;
    _data['likes'] = likes;
    _data['dislikes'] = dislikes;
    _data['added_time'] = addedTime;
    return _data;
  }
}
