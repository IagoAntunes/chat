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
      leading: Image.network(
        listImages[user.indexImage],
      ),
      title: Text(
        user.username,
        style: TextStyle(
          color: currentTheme.isdark ? Colors.white : Colors.black,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        user.description == "" ? 'New in Whatsapp' : user.description,
        style: TextStyle(
          color: currentTheme.isdark ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.qr_code,
        color: const Color(0xff03AA82),
      ),
    );
  }
}
