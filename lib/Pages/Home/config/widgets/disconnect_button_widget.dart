import 'package:flutter/material.dart';

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
          widget.socket!.disconnect();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: ((context) => const CreateUserPage()),
            ),
          );
        }),
        child: const Text('Disconnect'));
  }
}
