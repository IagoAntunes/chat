import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../Config/config.dart';
import '../../../../Models/user_model.dart';
import '../chat_page.dart';

class ListMessages extends StatelessWidget {
  const ListMessages({
    Key? key,
    required this.aux,
    required this.widget,
    required this.user,
  }) : super(key: key);

  final StreamController aux;
  final ChatPage widget;
  final User user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: aux.stream,
      builder: (context, snapshot) {
        return Expanded(
          child: ListView.builder(
            itemCount: widget.rede.listMessages.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Align(
                  alignment:
                      widget.rede.listMessages[index].user == user.username
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                  child: Stack(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 90,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: widget.rede.listMessages[index].user ==
                                      user.username
                                  ? const Radius.circular(10)
                                  : const Radius.circular(0),
                              topRight: const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight:
                                  widget.rede.listMessages[index].user ==
                                          user.username
                                      ? const Radius.circular(0)
                                      : const Radius.circular(10),
                            ),
                            color: currentTheme.isdark
                                ? const Color(0xff1C2D35)
                                : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.rede.listMessages[index].user,
                                      style: TextStyle(
                                        color: Color(
                                          widget.rede.listMessages[index].color,
                                        ),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    widget.rede.listMessages[index].mensagem,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: currentTheme.isdark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 2,
                        child: Text(
                          widget.rede.listMessages[index].time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
