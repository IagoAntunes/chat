import 'package:flutter/material.dart';

import '../Models/user_model.dart';

class userProvider extends ChangeNotifier {
  User? user;

  get getUser {
    return user;
  }

  void setUser(User userSet) {
    user = userSet;
  }
}
