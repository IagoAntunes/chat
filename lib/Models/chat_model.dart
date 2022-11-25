import 'package:socketfront/Models/user_model.dart';

class Chat {
  User user;
  bool isServer;
  String? host;
  String? port;
  Chat({
    required this.user,
    required this.isServer,
    required this.host,
    required this.port,
  });
}
