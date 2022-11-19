import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketfront/Pages/Home/status/personal_chat_page.dart';
import 'package:socketfront/Pages/Home/whats/chat_page.dart';

import '../../../Models/chat_model.dart';
import '../../../Models/rede_model.dart';
import '../../../Models/user_model.dart';
import '../../../Config/config.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({
    super.key,
    this.socket,
    required this.rede,
  });
  final IO.Socket? socket;
  final RedeModel rede;
  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final User user = userProv.getUser;
  final Chat chat = chatProv.getChat;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white,
      body: Visibility(
        visible: widget.socket != null,
        child: ListView.builder(
          itemCount: widget.rede.usersOnline!.length,
          itemBuilder: ((context, index) {
            return ListTile(
              leading: const Icon(
                Icons.circle,
                color: Colors.green,
              ),
              title: Text(
                widget.rede.usersOnline![index].user,
                style: TextStyle(
                  color: currentTheme.isdark ? Colors.white : Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChatPage(
                            rede: widget.rede,
                            socket: widget.socket,
                            isPrivate: true,
                            user: widget.rede.usersOnline![index],
                          ))

                      // PersonalPage(
                      //       rede: widget.rede,
                      //       socket: widget.socket!,
                      //       user: widget.rede.usersOnline![index],
                      //     )),
                      ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
