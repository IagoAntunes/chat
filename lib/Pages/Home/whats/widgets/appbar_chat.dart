import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../Config/config.dart';
import '../../../../Models/chat_model.dart';
import '../../../onlines_page.dart';
import '../chat_page.dart';

class AppBarChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarChat({
    Key? key,
    required this.socket,
    required this.chat,
    required this.widget,
  }) : super(key: key);

  final Socket? socket;
  final Chat chat;
  final ChatPage widget;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (socket != null) {
            socket!.close();
            socket!.destroy();
            Navigator.maybePop(context);
          }
          if (chat.isServer) {
            Navigator.pop(context);
            // widget.socket.disconnect();
          }
          if (!chat.isServer) {
            Navigator.pop(context);
            // widget.socket.disconnect();
          }
        },
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: currentTheme.isdark
          ? const Color(0xff1C2D35)
          : const Color(0xff075e55),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Geral'),
          Row(
            children: [
              const Icon(Icons.call),
              const Icon(Icons.video_call),
              IconButton(
                icon: const Icon(Icons.online_prediction),
                onPressed: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => OnlinePage(
                            rede: widget.rede,
                          )),
                    ),
                  );
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
