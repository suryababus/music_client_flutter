import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sociomusic/controller/message_controller.dart';
import 'package:sociomusic/controller/room_controller.dart';
import 'package:sociomusic/controller/socket_controller.dart';

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
      leadingWidth: 100,
      bottom: _TabBar(),
      actions: [
        IconButton(
          onPressed: () {
            print('settings pressed');
          },
          icon: Icon(
            Icons.share_sharp,
            color: Color(0Xff0177fa),
          ),
        )
      ],
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Color(0Xff0177fa),
            ),
            Text(
              'Back',
              style: TextStyle(
                color: Color(0Xff0177fa),
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
              child: TabBarView(
                  controller: tabController,
                  children: [MusicTabView(), MessageTabView()]),
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
          color: tabController?.index == 0 ? Color(0Xff0177fa) : Colors.white,
        ),
      ),
      new Tab(
          icon: Icon(
        tabController?.index == 1
            ? Icons.chat_bubble_rounded
            : Icons.chat_bubble_outline,
        color: tabController?.index == 1 ? Color(0Xff0177fa) : Colors.white,
      )),
    ]);
  }
}

class MessageTabView extends StatelessWidget {
  MessageTabView({
    Key? key,
  }) : super(key: key);
  var socketController = Get.find<SocketController>();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: GetBuilder<MessageController>(builder: (messageController) {
            return ListView.builder(
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  var message = messageController.messages[index];
                  switch (message.messageType) {
                    case MessageType.OWN_Message:
                      return MessageSentByUser(message);
                    case MessageType.OTHERS_MESSAGE:
                      return MessageFromOtherUsers(message);
                    case MessageType.INFO:
                      return MessageInfo(message);
                  }
                });
          }),
        ),
        ListTile(
          title: Expanded(
              child: TextField(
            controller: textController,
            style: TextStyle(color: Colors.white),
          )),
          trailing: IconButton(
              onPressed: () {
                socketController.send("text_message",
                    data: textController.text);
                textController.text = "";
              },
              icon: Icon(
                Icons.send_rounded,
                color: Colors.blue,
              )),
        )
      ],
    );
  }
}

class MessageInfo extends StatelessWidget {
  final Message message;
  const MessageInfo(Message _message) : message = _message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            message.message,
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}

class MessageSentByUser extends StatelessWidget {
  final Message message;
  const MessageSentByUser(Message _message) : message = _message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 20,
          ),
          child: Text(
            message.message,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ],
    );
  }
}

class MessageFromOtherUsers extends StatelessWidget {
  final Message message;
  const MessageFromOtherUsers(Message _message) : message = _message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 20,
          ),
          child: Text(
            'Message',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ],
    );
  }
}
