import 'package:flutter/material.dart';
import 'package:socketfront/Pages/CreateUser/create_user_page.dart';
import 'package:socketfront/Config/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key, this.socket});
  final IO.Socket? socket;
  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool isChecked = false;
  User user = userProv.getUser;
  Chat chat = chatProv.getChat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white,
      appBar: AppBar(
        backgroundColor: currentTheme.isdark
            ? const Color(0xff1C2D35)
            : const Color(0xff075e55),
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: currentTheme.isdark ? Colors.white : Colors.black,
            ),
            title: Text(
              user.username,
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              user.description,
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(
                  currentTheme.isdark ? Icons.dark_mode : Icons.light_mode,
                  color: currentTheme.isdark ? Colors.white : Colors.black,
                ),
                Checkbox(
                  fillColor: MaterialStateProperty.all(
                      currentTheme.isdark ? Colors.white : Colors.black),
                  value: isChecked,
                  onChanged: ((value) => setState(() {
                        currentTheme.switchTheme();
                        isChecked = !isChecked;
                      })),
                ),
              ],
            ),
          ),
          Visibility(
            visible: chat.isServer,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(width: 1, color: Colors.red),
                  foregroundColor: Colors.red,
                ),
                onPressed: (() {
                  widget.socket!.disconnect();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const CreateUserPage()),
                    ),
                  );
                }),
                child: const Text('Disconnect')),
          ),
        ],
      ),
    );
  }
}
