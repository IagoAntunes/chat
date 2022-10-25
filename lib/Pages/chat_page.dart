import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/config.dart';

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
  final String user = 'Iago';
  final aux = StreamController();
  bool isMic = true;
  Socket? socket;
  void connect() async {
    try {
      socket = await Socket.connect(widget.rede.host, widget.rede.porta)
          .then((socket) {
        print(
            'client connected : ${socket.remoteAddress.address}:${socket.remotePort}');

        socket.listen((data) {
          aux.add(data);
          print(utf8.decode(data));
          if (utf8.decode(data) == 'Erro') {
          } else {
            widget.rede.listMessages
                .add(MessageModel.fromMap(json.decode(utf8.decode(data))));
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

  @override
  Widget build(BuildContext context) {
    connect();
    return Scaffold(
      appBar: AppBar(
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
                const Icon(
                  Icons.menu_outlined,
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white70,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: aux.stream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: widget.rede.listMessages.length,
                      itemBuilder: ((context, index) {
                        return SizedBox(
                          width: 20,
                          child: Container(
                            width: double.minPositive,
                            decoration: BoxDecoration(
                              color: currentTheme.isdark
                                  ? const Color(0xff1C2D35)
                                  : const Color(0xff1FBD68),
                            ),
                            child: Text(
                              widget.rede.listMessages[index].mensagem,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: currentTheme.isdark
                            ? Color(0xff1C2D35)
                            : Colors.white,
                        borderRadius: BorderRadius.all(
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
                                  ? Color(0xff8097A1)
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
                      decoration: BoxDecoration(
                        color: Color(0xff03AA82),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: IconButton(
                        onPressed: (() {
                          sendMessage();
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

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      var req = {};
      req['user'] = user;
      req['msg'] = _controller.text;
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
