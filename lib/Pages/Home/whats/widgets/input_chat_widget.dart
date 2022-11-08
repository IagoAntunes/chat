import 'package:flutter/material.dart';

import '../../../../Config/config.dart';
import '../../../../Models/chat_model.dart';

class InputChat extends StatelessWidget {
  InputChat(
      {Key? key,
      required TextEditingController controller,
      required this.isMic,
      required this.chat,
      required this.sendMessage,
      required this.sendMessageServer})
      : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final bool isMic;
  Function sendMessageServer;
  Function sendMessage;
  Chat chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color:
                  currentTheme.isdark ? const Color(0xff1C2D35) : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                onChanged: ((value) {
                  // setState(
                  //   () {
                  //     isMic = value.isEmpty ? true : false;
                  //   },
                  // );
                }),
                controller: _controller,
                style: TextStyle(
                  color: currentTheme.isdark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Mensagem',
                  hintStyle: TextStyle(
                    color: currentTheme.isdark
                        ? const Color(0xff8097A1)
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff03AA82),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: (() {
                chat.isServer ? sendMessageServer() : sendMessage();
              }),
              icon: Icon(
                isMic ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
