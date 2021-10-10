import 'package:flutter/material.dart';
import 'package:sociomusic/api/SpotifyAPI.dart';

class RoomScreen extends StatefulWidget {
  RoomScreen({Key? key}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    getSongs();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    tabController?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void getSongs() async {
    var _recentPlayedSongs = await SpotifyWeb.getRecentPlayed();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      leadingWidth: 100,
      bottom: _TabBar(),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.red[500],
            ),
            Text(
              'Exit',
              style: TextStyle(
                color: Colors.red[500],
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
      title: Text(
        'Radio',
        style: Theme.of(context).textTheme.headline1,
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: tabController, children: [
                MusicTabView(),
                Center(
                  child: Text(
                    'Message',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
              ]),
            ),
            PlayerControl()
          ],
        ),
      ),
    );
  }

  TabBar _TabBar() {
    return new TabBar(controller: tabController, tabs: <Tab>[
      new Tab(
        icon: Icon(
          tabController?.index == 0
              ? Icons.music_note_rounded
              : Icons.music_note_outlined,
          color: tabController?.index == 0 ? Color(0XFFC3A137) : Colors.white,
        ),
      ),
      new Tab(
          icon: Icon(
        tabController?.index == 1
            ? Icons.chat_bubble_rounded
            : Icons.chat_bubble_outline,
        color: tabController?.index == 1 ? Color(0XFFC3A137) : Colors.white,
      )),
    ]);
  }
}

class PlayerControl extends StatelessWidget {
  const PlayerControl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stay',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'The Kid LAROI, Justin Bieber',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: Colors.white.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.play_circle_rounded,
              size: 80,
              color: Color(0XFFC3A137).withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }
}

class MusicTabView extends StatelessWidget {
  const MusicTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
              itemCount: 20,
              itemBuilder: (_, index) {
                return RadioLineItem();
              }),
          Positioned(
            bottom: 5,
            child: Center(
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Color(0XFFC3A137).withOpacity(0.9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    )),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Add Song',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RadioLineItem extends StatelessWidget {
  RadioLineItem({
    Key? key,
  }) : super(key: key);
  var imageUrl =
      'https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/The_Kid_Laroi_and_Justin_Bieber_-_Stay.png/220px-The_Kid_Laroi_and_Justin_Bieber_-_Stay.png';
  var songName = 'Love Me Like You Do';
  var addedBy = 'Surya babu';
  var likesCount = '1000';
  var dislikeCount = '20';
  var userAction = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 50,
      child: Row(
        children: [
          Image.network(
            imageUrl,
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songName,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Added By: ' + addedBy,
                    style: TextStyle(color: Colors.white.withOpacity(0.3)),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      userAction == 'liked'
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: Colors.green,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        likesCount,
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      userAction == 'disliked'
                          ? Icons.thumb_down_alt
                          : Icons.thumb_down_alt_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        dislikeCount,
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.white,
    );
  }
}
