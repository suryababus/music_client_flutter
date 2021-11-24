import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/api/socio_music/socio_api.dart';
import 'package:sociomusic/api/spotify/spotify_api.dart';
import 'package:sociomusic/api/spotify/response/search_track.dart';
import 'package:sociomusic/controller/room_controller.dart';

class AddSongModal extends StatefulWidget {
  const AddSongModal({
    Key? key,
  }) : super(key: key);

  @override
  _AddSongModalState createState() => _AddSongModalState();
}

class _AddSongModalState extends State<AddSongModal> {
  Future<SearchTrackResult>? searchTrackResult;
  String searchKey = '';
  @override
  void initState() {
    super.initState();
  }

  void onKeyChange(key) {
    if (key == '') return;
    if (searchKey == key) return;
    setState(() {
      searchKey = key;
    });
    searchTrackResult = SpotifyWeb.searchTracks(key);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            height: 70,
            child: TextField(
              autofocus: true,
              keyboardAppearance: Brightness.dark,
              onChanged: onKeyChange,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Search',
                icon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search_rounded,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                hintStyle: TextStyle(
                  color: Color(0XFF5A5959),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder<SearchTrackResult>(
                future: searchTrackResult,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SearchResultList(searchTrackResult: snapshot.data!);
                  }
                  return Center(
                      child: Text(
                    'No Result Matching',
                    style: TextStyle(color: Colors.white),
                  ));
                }),
          ),
        ],
      ),
    );
  }
}

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    Key? key,
    required this.searchTrackResult,
  }) : super(key: key);
  final SearchTrackResult searchTrackResult;

  @override
  Widget build(BuildContext context) {
    List<Items> items = searchTrackResult.tracks.items;
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SearchLineItem(item: items[index]);
        });
  }
}

class SearchLineItem extends StatelessWidget {
  SearchLineItem({Key? key, required this.item}) : super(key: key);
  final Items item;
  RoomController roomController = Get.find<RoomController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.network(item.album.images[0].url),
          title: Text(
            item.name,
            style: TextStyle(color: Colors.white),
          ),
          trailing: (Icon(
            Icons.add_outlined,
            color: Colors.green,
          )),
          onTap: onMusicAdd,
        ),
        Divider(
          color: Colors.white,
        ),
      ],
    );
  }

  void onMusicAdd() async {
    Map<String, String> song = {
      "name": item.name,
      "spotify_uri": item.uri,
      "spotify_id": item.id,
      "artist_id": item.artists[0].id,
      "artist_name": item.artists[0].name,
      "image_url_large": item.album.images[0].url,
      "image_url_medium": item.album.images[1].url,
      "image_url_small": item.album.images[2].url,
      "duration_ms": item.durationMs.toString()
    };
    if (await addSongToRoom(
        roomController.rooms[roomController.selectedRoomIndex].id, song)) {
      print('added');
      Get.back();
    } else {
      print('not added');
    }
  }
}
