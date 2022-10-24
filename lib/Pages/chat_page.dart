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
            ? const Color(0xff333333)
            : const Color(0xff1FBD68),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: aux.stream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: widget.rede.listMessages.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: currentTheme.isdark
                                ? const Color(0xff333333)
                                : const Color(0xff1FBD68),
                          ),
                          child: Text(
                            widget.rede.listMessages[index].mensagem,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Form(
                child: TextFormField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: const Icon(Icons.send)),
                    labelText: 'Send a message',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _sendMessage,
      //   tooltip: 'Send message',
      //   child: const Icon(Icons.send),
      // ),
    );
  }

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      var req = {};
      req['user'] = user;
      req['msg'] = _controller.text;
      socket!.write(json.encode(req));
    }
  }

  @override
  void dispose() {
    // _channel.sink.close();
    // _controller.dispose();
    super.dispose();
  }
}
