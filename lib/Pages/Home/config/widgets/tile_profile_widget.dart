import 'package:flutter/material.dart';

import '../../../../Config/config.dart';
import '../../../../Models/user_model.dart';

class TileProfile extends StatelessWidget {
  const TileProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: currentTheme.isdark ? Colors.white : Colors.black,
      ),
      title: Text(
        user.username,
        style: TextStyle(
          color: currentTheme.isdark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        user.description,
        style: TextStyle(
          color: currentTheme.isdark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
