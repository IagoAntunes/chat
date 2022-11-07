import 'package:socketfront/Models/user_model.dart';

class Chat {
  User user;
  bool isServer;
  Chat({
    required this.user,
    required this.isServer,
  });
}
