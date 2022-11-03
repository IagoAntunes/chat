import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Models/chat_model.dart';
import '../Models/message_model.dart';
import '../Models/rede_model.dart';
import '../Models/user_model.dart';
import '../config.dart';

class StatusPage extends StatefulWidget {
  StatusPage({
    super.key,
  });
  RedeModel rede =
      RedeModel(porta: 111, host: '111', listMessages: [], usersOnline: []);
  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  late IO.Socket _socket;
  final User user = userProv.getUser;
  Chat chat = chatProv.getChat;
  void connect3() {
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
    _socket.on('users', (data) {
      widget.rede.usersOnline = [];
      for (var user in data) {
        setState(() {
          widget.rede.usersOnline!.add(user['user']);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.rede.usersOnline!.length,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(widget.rede.usersOnline![index]),
          );
        }),
      ),
    );
  }
}
