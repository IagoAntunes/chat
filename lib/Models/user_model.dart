import 'package:flutter/animation.dart';

class User {
  String username;
  String description;
  int color;

  User({
    required this.username,
    this.description = "A guy in the world",
    required this.color,
  });
}
