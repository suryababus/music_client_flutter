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
    required this.songSpotifyUri,
    required this.songSpotifyImage,
    required this.createdTime,
    required this.modifiedTime,
    required this.createdBy,
    required this.modifiedBy,
    required this.songs,
  });
  late final String id;
  late final String name;
  late final String songSpotifyUri;
  late final String songSpotifyImage;
  late final String createdTime;
  late final String modifiedTime;
  late final CreatedBy createdBy;
  late final ModifiedBy modifiedBy;
  late final List<Song> songs;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    songSpotifyUri = json['song_spotify_uri'];
    songSpotifyImage = json['song_spotify_image'];
    createdTime = json['created_time'];
    modifiedTime = json['modified_time'];
    createdBy = CreatedBy.fromJson(json['created_by']);
    modifiedBy = ModifiedBy.fromJson(json['modified_by']);
    songs = List.from(json['songs']).map((e) => Song.fromJson(e)).toList();
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

class Song {
  Song({
    required this.id,
    required this.spotifyUri,
    required this.name,
    required this.spotifyId,
    required this.imageUrlSmall,
    required this.imageUrlMedium,
    required this.imageUrlLarge,
    required this.artistName,
    required this.artistId,
    required this.durationMs,
    required this.likes,
    required this.dislikes,
    required this.addedByUserName,
    required this.addedTime,
    required this.reaction,
  });
  late final String id;
  late final String spotifyUri;
  late final String name;
  late final String spotifyId;
  late final String imageUrlSmall;
  late final String imageUrlMedium;
  late final String imageUrlLarge;
  late final String artistName;
  late final String artistId;
  late final String durationMs;
  late final int likes;
  late final int dislikes;
  late final String addedByUserName;
  late final String addedTime;
  late final String reaction;

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spotifyUri = json['spotify_uri'];
    name = json['name'];
    spotifyId = json['spotify_id'];
    imageUrlSmall = json['image_url_small'];
    imageUrlMedium = json['image_url_medium'];
    imageUrlLarge = json['image_url_large'];
    artistName = json['artist_name'];
    artistId = json['artist_id'];
    durationMs = json['duration_ms'];
    likes = json['likes'];
    dislikes = json['dislikes'];
    addedByUserName = json['added_by_user_name'];
    addedTime = json['added_time'];
    reaction = json['reaction'] ?? 'none';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['spotify_uri'] = spotifyUri;
    _data['name'] = name;
    _data['spotify_id'] = spotifyId;
    _data['image_url_small'] = imageUrlSmall;
    _data['image_url_medium'] = imageUrlMedium;
    _data['image_url_large'] = imageUrlLarge;
    _data['artist_name'] = artistName;
    _data['artist_id'] = artistId;
    _data['duration_ms'] = durationMs;
    _data['likes'] = likes;
    _data['dislikes'] = dislikes;
    _data['added_by_user_name'] = addedByUserName;
    _data['added_time'] = addedTime;
    _data['reaction'] = reaction;
    return _data;
  }
}
