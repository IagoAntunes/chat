import 'package:flutter/material.dart';

import '../Models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  get getUser {
    return user;
  }

  void setUser(User? userSet) {
    user = userSet;
    notifyListeners();
  }
}
