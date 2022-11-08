import 'package:flutter/material.dart';
import 'package:socketfront/Pages/CreateUser/create_user_page.dart';
import 'package:socketfront/Config/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socketfront/Pages/Home/config/widgets/disconnect_button_widget.dart';
import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';
import 'widgets/checkbox_theme_widget.dart';
import 'widgets/tile_profile_widget.dart';

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
          TileProfile(user: user),
          CheckBoxTheme(isChecked: isChecked),
          Visibility(
            visible: chat.isServer,
            child: DisconnectButton(widget: widget),
          ),
        ],
      ),
    );
  }
}
