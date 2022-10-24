import 'package:socketfront/Models/message_model.dart';

class RedeModel {
  int porta;
  String host;
  List<MessageModel> listMessages;

  RedeModel({
    required this.porta,
    required this.host,
    required this.listMessages,
  });
}
