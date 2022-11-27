import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          currentTheme.isdark ? const Color(0xff121B22) : Colors.white,
      appBar: AppBar(
        backgroundColor: currentTheme.isdark
            ? const Color(0xff1C2D35)
            : const Color(0xff008069),
        title: const Text('Settings'),
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: currentTheme.isdark
              ? const Color(0xff1C2D35)
              : const Color(0xff008069),

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TileProfile(user: user),
          ),
          Divider(
            color: currentTheme.isdark ? const Color(0xffABABAB) : Colors.grey,
            indent: 40,
            endIndent: 40,
          ),
          CheckBoxTheme(isChecked: isChecked),
          TileConfigs(
            icon: Icons.key,
            title: 'Account',
            subtitle: 'Notificações de segurança, mudança de numero',
          ),
          TileConfigs(
            icon: Icons.lock,
            title: 'Privacy',
            subtitle: 'Security notifications, number change',
          ),
          TileConfigs(
            icon: Icons.chat,
            title: 'Chats',
            subtitle: 'Theme, wallpapers, chat history',
          ),
          TileConfigs(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Message, group & call tones',
          ),
          TileConfigs(
            icon: Icons.storage,
            title: 'Storage and data',
            subtitle: 'Network usage, auto-download',
          ),
          Visibility(
            visible: chat.isServer,
            child: DisconnectButton(widget: widget),
          ),
        ],
      ),
    );
  }
}

class TileConfigs extends StatelessWidget {
  TileConfigs(
      {super.key,
      required this.icon,
      required this.subtitle,
      required this.title});
  IconData icon;
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: currentTheme.isdark ? const Color(0xffABABAB) : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: currentTheme.isdark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: currentTheme.isdark ? const Color(0xffABABAB) : Colors.black,
        ),
      ),
    );
  }
}
