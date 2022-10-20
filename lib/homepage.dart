import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://192.168.5.213:4580'),
  );

  final String host = '192.168.5.213';
  final int porta = 4580;
  final String user = 'Iago';
  final aux = StreamController();

  Socket? socket;
  void connect() async {
    try {
      socket = await Socket.connect(host, porta).then((socket) {
        print(
            'client connected : ${socket.remoteAddress.address}:${socket.remotePort}');

        socket.listen((data) {
          aux.add(data);
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: aux.stream,
              builder: (context, snapshot) {
                return Text(
                    snapshot.hasData ? '${utf8.decode(snapshot.data)}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      socket!.write(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
