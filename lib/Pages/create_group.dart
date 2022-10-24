import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/config.dart';

import '../Models/rede_model.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  TextEditingController controllerHost = TextEditingController();
  TextEditingController controllerPort = TextEditingController();
  ServerSocket? server;
  void closeGroup() async {
    if (server != null) {
      await server!.close();
      print('Servidor fechado');
    }
  }

  Future<void> iniServer(List<String> arguments) async {
    if (arguments.isEmpty) {
      var filename = Platform.script.toFilePath().split('/').last; // wtf
      print('Usage: $filename <port>');
      return;
    }
    // All connected sockets
    final Set<Socket> sockets = {};

    // TCP server itself
    server = await ServerSocket.bind('0.0.0.0', int.parse(arguments[0]));
    print('// Launched server on port ${int.parse(arguments[0])}\n');
    server!.listen((socket) {
      // Add fresh connected client to the list
      print('entrei ${sockets.length}');
      print(socket.remoteAddress);
      sockets.add(socket);
      // Send MOTD
      socket.listen(
        (packet) {
          var pack = utf8.decode(packet, allowMalformed: true).trim();
          try {
            // Check if message is empty
            print(pack);
            var recv = json.decode(pack);
            if (recv['msg'] == '') {
            } else {
              // Broadcast it to all connected cleints
              for (final s in sockets) {
                s.add(utf8.encode(pack));
              }
            }
          } on FormatException catch (e) {
            // In case the packet is using the v1 system (plaintext)
            print(e.message);
            print('v1 packet: $pack');
          }
        },
      )
        // Remove the socket from the list on disconnect or error
        ..onError((_) {
          socket.close();
          sockets.remove(socket);
        })
        ..onDone(() {
          socket.close();
          sockets.remove(socket);
        });
    });
    RedeModel rede = RedeModel(
      porta: int.parse(controllerPort.text),
      host: controllerHost.text,
      listMessages: [],
    );
    Navigator.pop(context, rede);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Sala'),
        backgroundColor:
            currentTheme.isdark ? Color(0xff333333) : Color(0xff1FBD68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            decoration: InputDecoration(hintText: 'PORT:'),
            controller: controllerPort,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'HOST:'),
            controller: controllerHost,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red),
              ),
              onPressed: (() => closeGroup()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  Text(
                    'Close Server',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        backgroundColor:
            currentTheme.isdark ? Color(0xff333333) : Color(0xff1FBD68),
        onPressed: (() => iniServer(
              [controllerPort.text],
            )),
      ),
    );
  }
}
