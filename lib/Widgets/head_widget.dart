import 'package:flutter/material.dart';
import 'package:socketfront/Pages/Home/config/config_page.dart';
import 'package:socketfront/Config/config.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../Models/chat_model.dart';

class HeadWidget extends StatelessWidget {
  HeadWidget({Key? key, this.socket}) : super(key: key);
  final IO.Socket? socket;
  final Chat chat = chatProv.getChat;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentTheme.isdark
            ? const Color(0xff1F2C34)
            : const Color(0xff008069),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WhatsApp',
                  style: TextStyle(
                    color: currentTheme.isdark
                        ? const Color(0xffABABAB)
                        : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: currentTheme.isdark
                          ? const Color(0xffABABAB)
                          : Colors.white,
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: currentTheme.isdark
                            ? const Color(0xffABABAB)
                            : Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 2.0, color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => chat.isServer
                                  ? ConfigPage(
                                      socket: socket,
                                    )
                                  : const ConfigPage()),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                        PopupMenuItem<dynamic>(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Settings'),
                              Icon(Icons.toll_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TabBar(
                labelColor: currentTheme.isdark
                    ? const Color(0xff008069)
                    : Colors.white,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4.0,
                    color: currentTheme.isdark
                        ? const Color(0xff008069)
                        : Colors.white,
                  ),
                ),
                unselectedLabelColor: currentTheme.isdark
                    ? const Color(0xff8097A1)
                    : Colors.white.withOpacity(0.4),
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(
                    child: Text(
                      'CHATS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'STATUS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'CALLS',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
