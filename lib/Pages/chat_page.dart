import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Pages/onlines_page.dart';
import 'package:socketfront/Providers/user_provider.dart';
import 'package:socketfront/config.dart';

import '../Models/chat_model.dart';
import '../Models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.rede});

  RedeModel rede;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  // final _channel = WebSocketChannel.connect(
  //   Uri.parse('wss://192.168.5.213:4580'),
  // );

  final String host = '192.168.5.59';
  final int porta = 4580;
  final aux = StreamController();
  final User user = userProv.getUser;
  bool isMic = true;
  bool isConnected = false;
  Socket? socket;
  late IO.Socket _socket;
  Chat chat = chatProv.getChat;

  //OLD CONNECT SERVER
  void connect() async {
    try {
      print('Entrei');
      socket = await Socket.connect(widget.rede.host, widget.rede.porta)
          .then((socket) {
        print(
            'client connected : ${socket.remoteAddress.address}:${socket.remotePort}');

        socket.listen((data) {
          print(data);
          aux.add(data);
          print(utf8.decode(data));
          if (utf8.decode(data) == 'Erro') {
          } else {
            widget.rede.listMessages.add(
              MessageModel.fromMap(
                json.decode(
                  utf8.decode(data),
                ),
              ),
            );
          }

          print("client listen  : ${String.fromCharCodes(data).trim()}");
        }, onDone: () {
          print("client done");
          socket.destroy();
        });
        return socket;
      });
    } on SocketException catch (e) {
      print(
          'Couldn\'t connect with the specified host:port combination. Aborting.');
      return;
    }
  }

  void connect3() {
    _socket.connect();
    _socket.onConnect((data) {
      print('Connected');
      _socket.emit('online', {
        'user': user.username,
      });
    });
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) {
      print('Socket.IO server disconnected');
    });
    _socket.on('message', (data) {
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
    _socket.on('online', (data) {
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
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    if (chat.isServer == true) {
      _socket = IO.io(
        'http://192.168.5.213:4590',
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': userProv.user!.username.toString()}).build(),
      );
      connect3();
    } else {
      connect();
    }
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
              _socket.disconnect();
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
                Icon(Icons.call),
                Icon(Icons.video_call),
                IconButton(
                  icon: Icon(Icons.online_prediction),
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
          : Color.fromARGB(255, 237, 238, 190),
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
                      itemCount: widget.rede.listMessages.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Align(
                            alignment: widget.rede.listMessages[index].user ==
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
                                        topLeft: widget.rede.listMessages[index]
                                                    .user ==
                                                user.username
                                            ? Radius.circular(10)
                                            : Radius.circular(0),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: widget.rede
                                                    .listMessages[index].user ==
                                                user.username
                                            ? Radius.circular(0)
                                            : Radius.circular(10),
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
                                                widget.rede.listMessages[index]
                                                    .user,
                                                style: TextStyle(
                                                  color: Color(
                                                    widget
                                                        .rede
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
                                              widget.rede.listMessages[index]
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessageServer() {
    if (_controller.text.isNotEmpty) {
      _socket.emit('message', {
        'msg': _controller.text.trim(),
        'user': user.username,
        'time': DateTime.now().toString().substring(11, 16).toString(),
        'color': user.color,
      });
      _controller.clear();
    }
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      var req = {};
      req['user'] = user.username;
      req['msg'] = _controller.text;
      req['time'] = DateTime.now().toString().substring(11, 16);
      req['color'] = user.color;
      print(DateTime.now().toString().substring(11, 16));
      if (socket != null) {
        socket!.write(json.encode(req));
      }
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    // _channel.sink.close();
    // _controller.dispose();
    super.dispose();
  }
}
