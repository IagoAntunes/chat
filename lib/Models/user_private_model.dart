// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:socketfront/Models/message_model.dart';

class UserPrivate {
  String user;
  String userId;
  List<MessageModel> listMessages;
  UserPrivate({
    required this.user,
    required this.userId,
    required this.listMessages,
  });
}
