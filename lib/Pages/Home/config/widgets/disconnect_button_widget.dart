import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Providers/chat_provider.dart';
import 'package:socketfront/Providers/user_provider.dart';
import 'package:socketfront/main.dart';

import '../../../CreateUser/create_user_page.dart';
import '../config_page.dart';

class DisconnectButton extends StatelessWidget {
  const DisconnectButton({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ConfigPage widget;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.red),
          foregroundColor: Colors.red,
        ),
        onPressed: (() {
          Provider.of<UserProvider>(context, listen: false).setUser(null);
          Provider.of<ChatProvider>(context, listen: false).setChat(null);
          widget.socket!.disconnect();
          widget.socket!.ondisconnect();
          widget.socket!.close();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => const MyApp()),
            ),
          );
        }),
        child: const Text('Disconnect'));
  }
}
