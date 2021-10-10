class RecentPlayedSongs {
  RecentPlayedSongs({
    required this.items,
    required this.next,
    required this.cursors,
    required this.limit,
    required this.href,
  });
  late final List<Items> items;
  late final String next;
  late final Cursors cursors;
  late final int limit;
  late final String href;

  RecentPlayedSongs.fromJson(Map<String, dynamic> json) {
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    next = json['next'];
    cursors = Cursors.fromJson(json['cursors']);
    limit = json['limit'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['next'] = next;
    _data['cursors'] = cursors.toJson();
    _data['limit'] = limit;
    _data['href'] = href;
    return _data;
  }
}

class Items {
  Items({
    required this.track,
    required this.playedAt,
    // required this.context,
  });
  late final Track track;
  late final String playedAt;
  // late final Context context;

  Items.fromJson(Map<String, dynamic> json) {
    track = Track.fromJson(json['track']);
    playedAt = json['played_at'];
    // context = Context.fromJson(json['context']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['track'] = track.toJson();
    _data['played_at'] = playedAt;
    // _data['context'] = context.toJson();
    return _data;
  }
}

class Track {
  Track({
    required this.album,
    required this.artists,
    required this.availableMarkets,
    required this.discNumber,
    required this.durationMs,
    required this.explicit,
    required this.externalIds,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.isLocal,
    required this.name,
    required this.popularity,
    required this.previewUrl,
    required this.trackNumber,
    required this.type,
    required this.uri,
  });
  late final Album album;
  late final List<Artists> artists;
  late final List<String> availableMarkets;
  late final int discNumber;
  late final int durationMs;
  late final bool explicit;
  late final ExternalIds externalIds;
  late final ExternalUrls externalUrls;
  late final String href;
  late final String id;
  late final bool isLocal;
  late final String name;
  late final int popularity;
  late final String previewUrl;
  late final int trackNumber;
  late final String type;
  late final String uri;

  Track.fromJson(Map<String, dynamic> json) {
    album = Album.fromJson(json['album']);
    artists =
        List.from(json['artists']).map((e) => Artists.fromJson(e)).toList();
    availableMarkets =
        List.castFrom<dynamic, String>(json['available_markets']);
    discNumber = json['disc_number'];
    durationMs = json['duration_ms'];
    explicit = json['explicit'];
    externalIds = ExternalIds.fromJson(json['external_ids']);
    externalUrls = ExternalUrls.fromJson(json['external_urls']);
    href = json['href'];
    id = json['id'];
    isLocal = json['is_local'];
    name = json['name'];
    popularity = json['popularity'];
    previewUrl = json['preview_url'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['album'] = album.toJson();
    _data['artists'] = artists.map((e) => e.toJson()).toList();
    _data['available_markets'] = availableMarkets;
    _data['disc_number'] = discNumber;
    _data['duration_ms'] = durationMs;
    _data['explicit'] = explicit;
    _data['external_ids'] = externalIds.toJson();
    _data['external_urls'] = externalUrls.toJson();
    _data['href'] = href;
    _data['id'] = id;
    _data['is_local'] = isLocal;
    _data['name'] = name;
    _data['popularity'] = popularity;
    _data['preview_url'] = previewUrl;
    _data['track_number'] = trackNumber;
    _data['type'] = type;
    _data['uri'] = uri;
    return _data;
  }
}

class Album {
  Album({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });
  late final String albumType;
  late final List<Artists> artists;
  late final List<String> availableMarkets;
  late final ExternalUrls externalUrls;
  late final String href;
  late final String id;
  late final List<Images> images;
  late final String name;
  late final String releaseDate;
  late final String releaseDatePrecision;
  late final int totalTracks;
  late final String type;
  late final String uri;

  Album.fromJson(Map<String, dynamic> json) {
    albumType = json['album_type'];
    artists =
        List.from(json['artists']).map((e) => Artists.fromJson(e)).toList();
    availableMarkets =
        List.castFrom<dynamic, String>(json['available_markets']);
    externalUrls = ExternalUrls.fromJson(json['external_urls']);
    href = json['href'];
    id = json['id'];
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    name = json['name'];
    releaseDate = json['release_date'];
    releaseDatePrecision = json['release_date_precision'];
    totalTracks = json['total_tracks'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['album_type'] = albumType;
    _data['artists'] = artists.map((e) => e.toJson()).toList();
    _data['available_markets'] = availableMarkets;
    _data['external_urls'] = externalUrls.toJson();
    _data['href'] = href;
    _data['id'] = id;
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['name'] = name;
    _data['release_date'] = releaseDate;
    _data['release_date_precision'] = releaseDatePrecision;
    _data['total_tracks'] = totalTracks;
    _data['type'] = type;
    _data['uri'] = uri;
    return _data;
  }
}

class Artists {
  Artists({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });
  late final ExternalUrls externalUrls;
  late final String href;
  late final String id;
  late final String name;
  late final String type;
  late final String uri;

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = ExternalUrls.fromJson(json['external_urls']);
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['external_urls'] = externalUrls.toJson();
    _data['href'] = href;
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['uri'] = uri;
    return _data;
  }
}

class ExternalUrls {
  ExternalUrls({
    required this.spotify,
  });
  late final String spotify;

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['spotify'] = spotify;
    return _data;
  }
}

class Images {
  Images({
    required this.height,
    required this.url,
    required this.width,
  });
  late final int height;
  late final String url;
  late final int width;

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['height'] = height;
    _data['url'] = url;
    _data['width'] = width;
    return _data;
  }
}

class ExternalIds {
  ExternalIds({
    required this.isrc,
  });
  late final String isrc;

  ExternalIds.fromJson(Map<String, dynamic> json) {
    isrc = json['isrc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isrc'] = isrc;
    return _data;
  }
}

class Context {
  Context({
    required this.externalUrls,
    required this.href,
    required this.type,
    required this.uri,
  });
  late final ExternalUrls externalUrls;
  late final String href;
  late final String type;
  late final String uri;

  Context.fromJson(Map<String, dynamic> json) {
    externalUrls = ExternalUrls.fromJson(json['external_urls']);
    href = json['href'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['external_urls'] = externalUrls.toJson();
    _data['href'] = href;
    _data['type'] = type;
    _data['uri'] = uri;
    return _data;
  }
}

class Cursors {
  Cursors({
    required this.after,
    required this.before,
  });
  late final String after;
  late final String before;

  Cursors.fromJson(Map<String, dynamic> json) {
    after = json['after'];
    before = json['before'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['after'] = after;
    _data['before'] = before;
    return _data;
  }
}
