import 'package:get/get.dart';

enum MessageType { OWN_Message, OTHERS_MESSAGE, INFO }

class Message {
  late MessageType messageType;
  late String message;
  late String? userName;

  Message(MessageType _type, String _message, String? _userName) {
    messageType = _type;
    message = _message;
    userName = _userName;
  }
}

class MessageController extends GetxController {
  List<Message> messages = [];
  void addMessage(Message message) {
    messages.add(message);
    update();
  }
}
