import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:socketfront/Models/user_private_model.dart';
import 'package:socketfront/Pages/Home/status/status_page.dart';
import 'package:socketfront/Pages/Home/whats/whats_page.dart';
import 'package:socketfront/Config/config.dart';

import '../Models/chat_model.dart';
import '../Models/message_model.dart';
import '../Models/rede_model.dart';
import '../Models/user_model.dart';
import '../Widgets/head_widget.dart';

class TabBarDemo extends StatefulWidget {
  TabBarDemo({super.key});
  final RedeModel rede = RedeModel(
    porta: 111,
    host: '',
    listMessages: [],
    usersOnline: [],
  );
  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  User user = userProv.getUser;
  IO.Socket? _socket = null;
  Chat chat = chatProv.getChat;
  void connect3() {
    _socket!.onConnect((data) {
      print('Connected');
      _socket!.emit('online', {
        'user': user.username,
      });
    });
    _socket!.onConnectError((data) => print('Connect Error: $data'));
    _socket!.onDisconnect((data) {
      print('Socket.IO server disconnected');
    });
    _socket!.on('message', (data) {
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
    _socket!.on("private message", (data) {
      for (var i = 0; i < widget.rede.usersOnline!.length; i++) {
        if (widget.rede.usersOnline![i].userId == data['from']) {
          setState(() {
            widget.rede.usersOnline![i].listMessages.add(
              MessageModel(
                mensagem: data['msg'],
                user: widget.rede.usersOnline![i].user,
                time: data['time'],
                color: data['color'],
              ),
            );
          });
          break;
        }
      }
    });
    //Recebe usuarios que entrar ou desconectar
    _socket!.on('users', (data) {
      widget.rede.usersOnline = [];
      for (var user in data) {
        setState(() {
          if (user['user'] == chat.user.username) {
            chat.user.userID = user['userID'];
          }
          widget.rede.usersOnline!.add(
            UserPrivate(
              user: user['user'],
              userId: user['userID'],
              listMessages: [],
            ),
          );
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    currentTheme.addListener(() {
      print('Change Theme');
      if (mounted) setState(() {});
    });
    if (chat.isServer == true) {
      User user = userProv.getUser;
      setState(() {
        _socket = null;
        _socket = IO.io(
          'http://${chat.host}:${chat.port}',
          IO.OptionBuilder().setTransports(['websocket']).setQuery(
              {'username': user.username.toString()}).build(),
        );
      });

      print(_socket!.query);
      print(user.username.toString());
      connect3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentTheme.currentTheme(),
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: currentTheme.isdark ? Colors.green : Colors.white,
            ),
          ),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                HeadWidget(
                  socket: _socket,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      WhatsPage(rede: widget.rede, socket: _socket),
                      StatusPage(rede: widget.rede, socket: _socket),
                      Column(
                        children: const [
                          Icon(
                            Icons.call,
                            size: 120,
                          ),
                          Text('Sem Chamadas!')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
