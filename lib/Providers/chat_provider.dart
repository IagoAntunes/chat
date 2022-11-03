import 'package:flutter/material.dart';
import 'package:socketfront/Models/chat_model.dart';

import '../Models/user_model.dart';

class chatProvider extends ChangeNotifier {
  Chat? chat;

  get getChat {
    return chat;
  }

  void setChat(Chat chatSet) {
    chat = chatSet;
  }
}
