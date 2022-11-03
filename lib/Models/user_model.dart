import 'package:flutter/animation.dart';
import 'package:socketfront/Models/rede_model.dart';

class User {
  String username;
  String description;
  int color;
  List<RedeModel> listRedes;
  User(
      {required this.username,
      this.description = "A guy in the world",
      required this.color,
      required this.listRedes});
}
