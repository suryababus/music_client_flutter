import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';

import 'views/music_tab_item.dart';
import 'views/player_control.dart';

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
    Get.find<RoomController>().joinRoom();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    tabController?.addListener(() {
      //don't remove it
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      leadingWidth: 100,
      bottom: _TabBar(),
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.white54,
            ),
            Text(
              'Back',
              style: TextStyle(
                color: Colors.white54,
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
          color: tabController?.index == 0
              ? Colors.blue.withOpacity(0.8)
              : Colors.white,
        ),
      ),
      new Tab(
          icon: Icon(
        tabController?.index == 1
            ? Icons.chat_bubble_rounded
            : Icons.chat_bubble_outline,
        color: tabController?.index == 1
            ? Colors.blue.withOpacity(0.8)
            : Colors.white,
      )),
    ]);
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
