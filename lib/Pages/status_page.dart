import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketfront/Pages/personal_chat_page.dart';

import '../Models/chat_model.dart';
import '../Models/message_model.dart';
import '../Models/rede_model.dart';
import '../Models/user_model.dart';
import '../config.dart';

class StatusPage extends StatefulWidget {
  StatusPage({
    super.key,
    required this.socket,
    required this.rede,
  });
  IO.Socket socket;
  RedeModel rede;
  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final User user = userProv.getUser;
  Chat chat = chatProv.getChat;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.rede.usersOnline!.length,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Icon(
              Icons.circle,
              color: Colors.green,
            ),
            title: Text(widget.rede.usersOnline![index].user),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PersonalPage(
                        rede: widget.rede,
                        socket: widget.socket,
                        user: widget.rede.usersOnline![index],
                      )),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
