import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/Models/message_model.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Pages/onlines_page.dart';
import 'package:socketfront/Config/config.dart';

import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../Models/user_private_model.dart';
import 'widgets/appbar_chat.dart';
import 'widgets/input_chat_widget.dart';
import 'widgets/list_messages_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.rede,
    this.socket,
    this.user,
    this.isPrivate = false,
  });
  final IO.Socket? socket;
  final RedeModel rede;
  final UserPrivate? user;
  final bool isPrivate;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final String host = '192.168.5.59';
  final int porta = 4580;
  final aux = StreamController();
  final User user = userProv.getUser;
  bool isMic = true;
  bool isConnected = false;
  Socket? socket;
  Chat chat = chatProv.getChat;
  String? image;
  MessageModel message = MessageModel(
    mensagem: '',
    user: userProv.getUser.username,
    time: DateTime.now().toString().substring(11, 16).toString(),
    color: userProv.getUser.color,
  );

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
    widget.socket!.connect();
    widget.socket!.onConnect((data) {
      print('Connected');
      widget.socket!.emit('online', {
        'user': user.username,
      });
    });
    widget.socket!.onConnectError((data) => print('Connect Error: $data'));
    widget.socket!.onDisconnect((data) {
      print('Socket.IO server disconnected');
    });
    widget.socket!.on('message', (data) {
      if (mounted) {
        setState(() {
          widget.rede.listMessages.add(
            MessageModel.fromMap(
              data,
            ),
          );
        });
      }
      print(widget.rede.listMessages[0].mensagem
          .substring(6, widget.rede.listMessages[0].mensagem.length));
    });
    widget.socket!.on('online', (data) {
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
    if (!chat.isServer) {
      if (widget.rede.host.isNotEmpty) {
        connect();
      }
    }
    print(widget.rede.listMessages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarChat(
          socket: socket, chat: chat, widget: widget, user: widget.user),
      backgroundColor: currentTheme.isdark
          ? const Color(0xff121B22)
          : const Color.fromARGB(255, 237, 238, 190),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListMessages(
                aux: aux,
                widget: widget,
                user: user,
                isPrivate: widget.isPrivate,
              ),
              const SizedBox(height: 24),
              InputChat(
                controller: _controller,
                isMic: isMic,
                chat: chat,
                sendMessage: sendMessage,
                sendMessageServer:
                    widget.isPrivate ? sendMessagePrivate : sendMessageServer,
                message: message,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessageServer() {
    if (_controller.text.isNotEmpty) {
      widget.socket!.emit('message', {
        'msg': message.mensagem,
        'user': user.username,
        'time': DateTime.now().toString().substring(11, 16).toString(),
        'color': user.color,
      });
      _controller.clear();
    }
    _controller.text = '';
  }

  void sendMessagePrivate() {
    setState(() {
      widget.user!.listMessages.add(
        MessageModel(
          mensagem: message.mensagem,
          user: chat.user.username,
          time: DateTime.now().toString().substring(11, 16).toString(),
          color: chat.user.color,
        ),
      );
    });

    widget.socket!.emit("private message", {
      'msg': message.mensagem,
      'to': widget.user!.userId,
      'time': DateTime.now().toString().substring(11, 16).toString(),
      'color': user.color,
    });
    _controller.text = '';
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

  void sendImage() {
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
