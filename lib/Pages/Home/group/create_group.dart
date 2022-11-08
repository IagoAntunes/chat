import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socketfront/Config/config.dart';
import 'package:socketfront/Widgets/input_widget.dart';

import '../../../Models/rede_model.dart';

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
    // sockets conectados
    final Set<Socket> sockets = {};

    // TCP server
    server = await ServerSocket.bind('0.0.0.0', int.parse(arguments[0]));
    print('// Launched server on port ${int.parse(arguments[0])}\n');
    server!.listen((socket) {
      print('entrei ${sockets.length}');
      print(socket.remoteAddress);
      sockets.add(socket);
      // Send MOTD
      socket.listen(
        (packet) {
          var pack = utf8.decode(packet, allowMalformed: true).trim();
          try {
            // Ve se a mensagem esta vazia
            print(pack);
            var recv = json.decode(pack);
            if (recv['msg'] == '') {
            } else {
              // Todos usuarios conectados
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
        title: const Text('Criar Sala'),
        backgroundColor: currentTheme.isdark
            ? const Color(0xff1C2D35)
            : const Color(0xff075e55),
      ),
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Container(
              decoration: BoxDecoration(
                  color: currentTheme.isdark
                      ? const Color(0xff0F1C24)
                      : Colors.white),
              child: ListTile(
                leading: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: const Icon(
                      Icons.camera_enhance,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: TextField(
                  style: TextStyle(
                    color: currentTheme.isdark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Digite o nome do grupo...',
                    hintStyle: TextStyle(
                      color: currentTheme.isdark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomInput(
            controllerDescription: controllerPort,
            hintText: 'PORT:',
            icon: Icons.door_sliding,
            value: currentTheme.isdark,
          ),
          CustomInput(
            controllerDescription: controllerHost,
            hintText: 'HOST:',
            icon: Icons.access_alarm,
            value: currentTheme.isdark,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
              ),
              onPressed: (() => closeGroup()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
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
        backgroundColor: currentTheme.isdark
            ? const Color(0xff03AA82)
            : const Color(0xff03AA82),
        onPressed: (() => iniServer(
              [controllerPort.text],
            )),
        child: const Icon(Icons.create),
      ),
    );
  }
}
