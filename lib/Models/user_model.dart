import 'dart:ui';

import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/rede_model.dart';

class User {
  String userID;
  String username;
  String description;
  int color;
  int indexImage;
  List<RedeModel> listRedes;
  bool isOnline;
  List<MessageModel> listMessages;
  User({
    required this.username,
    this.description = "A guy in the world",
    required this.color,
    required this.listRedes,
    required this.isOnline,
    required this.listMessages,
    required this.indexImage,
    this.userID = '',
  });
}
