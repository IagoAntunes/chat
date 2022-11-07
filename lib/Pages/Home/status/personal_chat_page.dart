import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Models/user_private_model.dart';
import 'package:socketfront/Pages/onlines_page.dart';
import 'package:socketfront/Config/config.dart';

import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PersonalPage extends StatefulWidget {
  const PersonalPage({
    super.key,
    required this.rede,
    required this.socket,
    required this.user,
  });
  final IO.Socket socket;
  final RedeModel rede;
  final UserPrivate user;
  @override
  State<PersonalPage> createState() => PersonalPageState();
}

class PersonalPageState extends State<PersonalPage> {
  final TextEditingController _controller = TextEditingController();

  final String host = '192.168.5.59';
  final int porta = 4580;
  final aux = StreamController();
  final User user = userProv.getUser;
  bool isMic = true;
  bool isConnected = false;
  Socket? socket;
  Chat chat = chatProv.getChat;

  void connect3() {
    widget.socket.connect();
    widget.socket.onConnect((data) {
      print('Connected');
      widget.socket.emit('online', {
        'user': user.username,
      });
    });
    widget.socket.onConnectError((data) => print('Connect Error: $data'));
    widget.socket.onDisconnect((data) {
      print('Socket.IO server disconnected');
    });
    widget.socket.on('message', (data) {
      if (mounted) {
        setState(() {
          widget.rede.listMessages.add(
            MessageModel.fromMap(
              data,
            ),
          );
        });
      }
    });
    widget.socket.on('online', (data) {
      if (mounted) {
        setState(() {
          widget.rede.usersOnline = [];
          for (var user in data) {
            widget.rede.usersOnline!.add(user['user']);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (socket != null) {
              socket!.close();
            }
            if (chat.isServer) {
              Navigator.pop(context);
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
            const Text('Username'),
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
      ),
      backgroundColor: currentTheme.isdark
          ? const Color(0xff0F1C24)
          : const Color.fromARGB(255, 237, 238, 190),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: aux.stream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: widget.user.listMessages.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Align(
                            alignment: widget.user.listMessages[index].user ==
                                    user.username
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
                                        topLeft: widget.user.listMessages[index]
                                                    .user ==
                                                user.username
                                            ? const Radius.circular(10)
                                            : const Radius.circular(0),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: const Radius.circular(10),
                                        bottomRight: widget.user
                                                    .listMessages[index].user ==
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                widget.user.listMessages[index]
                                                    .user,
                                                style: TextStyle(
                                                  color: Color(
                                                    widget
                                                        .user
                                                        .listMessages[index]
                                                        .color,
                                                  ),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: Text(
                                              widget.user.listMessages[index]
                                                  .mensagem,
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
                                    widget.user.listMessages[index].time,
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
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentTheme.isdark
                            ? const Color(0xff1C2D35)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          onChanged: ((value) => setState(() {
                                isMic = value.isEmpty ? true : false;
                              })),
                          controller: _controller,
                          style: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.black,
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
                          sendMessageServer();
                        }),
                        icon: Icon(
                          isMic ? Icons.mic : Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessageServer() {
    setState(() {
      widget.user.listMessages.add(MessageModel(
        mensagem: _controller.text,
        user: chat.user.username,
        time: DateTime.now().toString().substring(11, 16).toString(),
        color: chat.user.color,
      ));
    });

    widget.socket.emit("private message", {
      'msg': _controller.text,
      'to': widget.user.userId,
      'time': DateTime.now().toString().substring(11, 16).toString(),
      'color': user.color,
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
