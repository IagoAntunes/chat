import 'package:flutter/material.dart';

import '../../../Config/config.dart';
import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';
import '../../tab_page.dart';

class ButtonNext extends StatelessWidget {
  const ButtonNext({
    Key? key,
    required this.controllerUser,
    required this.controllerDescription,
    required this.controllerHost,
    required this.controllerPort,
    required this.isSelected,
    required this.selectedColor,
    required this.indexImage,
  }) : super(key: key);

  final TextEditingController controllerUser;
  final TextEditingController controllerDescription;
  final TextEditingController controllerHost;
  final TextEditingController controllerPort;
  final bool isSelected;
  final Color selectedColor;
  final int indexImage;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isSelected) {
          if (controllerUser.text.isNotEmpty &&
              controllerHost.text.isNotEmpty &&
              controllerPort.text.isNotEmpty) {
            User user = User(
                username: controllerUser.text,
                description: controllerDescription.text,
                color: selectedColor.value,
                listRedes: [],
                isOnline: true,
                listMessages: [],
                indexImage: indexImage);
            userProv.setUser(user);
            Chat chat = Chat(
              user: user,
              isServer: isSelected,
              host: controllerHost.text,
              port: controllerPort.text,
            );
            chatProv.setChat(chat);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => TabBarDemo()),
              ),
            );
          }
        } else {
          if (controllerUser.text.isNotEmpty) {
            User user = User(
                username: controllerUser.text,
                description: controllerDescription.text,
                color: selectedColor.value,
                listRedes: [],
                isOnline: true,
                listMessages: [],
                indexImage: indexImage);
            userProv.setUser(user);
            Chat chat = Chat(
              user: user,
              isServer: isSelected,
              host: controllerHost.text,
              port: controllerPort.text,
            );
            chatProv.setChat(chat);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => TabBarDemo()),
              ),
            );
          }
        }
      },
      child: Text(isSelected ? 'Login' : 'Next'),
    );
  }
}
