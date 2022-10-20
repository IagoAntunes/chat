import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

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
  Socket? socket;
  void connect() async {
    try {
      socket = await Socket.connect(host, porta);
      print('// Connected to $host at $porta as $user\n');

      request();
    } on SocketException catch (e) {
      print(
          'Couldn\'t connect with the specified host:port combination. Aborting.');
      return;
    }
    socket!.write('ola mundo');
  }

  void request() {
    var req = new Map();
    req['user'] = user;
    stdin.listen((v) {
      req['msg'] = utf8.decode(v).trim();
      if (req['msg'] != '') {
        socket!.add(utf8.encode(jsonEncode(req)));
      }
    });
  }

  void messages() {
    socket!.listen((v) {
      var recv = utf8.decode(v, allowMalformed: true).trim();
      try {
        var recvj = json.decode(recv);
        print('<${recvj["user"]}> ' + recvj["msg"]);
      } on FormatException catch (e) {
        print('<v1 message> ' + recv);
      }
    });
  }

  void teste() async {
    Socket socket = await Socket.connect(host, porta);
    socket!.listen(
      // handle data from the server
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
      },

      // handle errors
      onError: (error) {
        print(error);
        socket!.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket!.destroy();
      },
    );
    _channel.sink.add('Sei la');
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
