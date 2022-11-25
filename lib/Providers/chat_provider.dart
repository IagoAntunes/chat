import 'package:flutter/material.dart';
import 'package:socketfront/Models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  Chat? chat;

  get getChat {
    return chat;
  }

  void setChat(Chat? chatSet) {
    chat = chatSet;
  }
}
