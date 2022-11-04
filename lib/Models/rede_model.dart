import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/user_private_model.dart';

class RedeModel {
  int porta;
  String host;
  List<MessageModel> listMessages;
  List<UserPrivate>? usersOnline = [];

  RedeModel({
    required this.porta,
    required this.host,
    required this.listMessages,
    this.usersOnline,
  });
}
