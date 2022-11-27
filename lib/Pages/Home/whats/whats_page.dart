import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Pages/Home/whats/widgets/custom_floatin_button.dart';
import 'package:socketfront/Pages/Home/whats/chat_page.dart';
import 'package:socketfront/Providers/user_provider.dart';
import 'package:socketfront/Config/config.dart';
import '../../../Models/chat_model.dart';
import '../../../Models/user_model.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WhatsPage extends StatefulWidget {
  const WhatsPage({
    super.key,
    required this.rede,
    this.socket,
  });

  final IO.Socket? socket;
  final RedeModel rede;
  @override
  State<WhatsPage> createState() => _WhatsPageState();
}

class _WhatsPageState extends State<WhatsPage> {
  User user = userProv.getUser;
  Chat chat = chatProv.getChat;
  List<RedeModel> listRedes = [];

  @override
  void initState() {
    if (user.listRedes.isEmpty) {
      if (chat.isServer) {
        user.listRedes.add(widget.rede);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerPorta = TextEditingController();
    TextEditingController controllerHost = TextEditingController();
    //Color(0xff121B22)
    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff121B22) : Colors.white,
      body: Consumer<UserProvider>(
        builder: ((context, value, child) => SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    //Lista Grupos
                    child: ListView.builder(
                      itemCount: user.listRedes.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          onTap: () => Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: ((context) => chat.isServer
                                  ? ChatPage(
                                      rede: user.listRedes[index],
                                      socket: widget.socket,
                                    )
                                  : ChatPage(
                                      rede: user.listRedes[index],
                                    )),
                            ),
                          )
                              .then((value) {
                            setState(() {});
                          }),
                          title: Text(
                            'Geral',
                            style: TextStyle(
                              color: currentTheme.isdark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: Container(
                            decoration: BoxDecoration(
                              color: currentTheme.isdark
                                  ? Colors.grey
                                  : Colors.grey.shade300,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(
                                Icons.group,
                                color: currentTheme.isdark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            user.listRedes[index].listMessages.isNotEmpty
                                ? user
                                            .listRedes[index]
                                            .listMessages[user.listRedes[index]
                                                    .listMessages.length -
                                                1]
                                            .mensagem
                                            .length >
                                        20
                                    ? (user
                                            .listRedes[index]
                                            .listMessages[user.listRedes[index]
                                                    .listMessages.length -
                                                1]
                                            .mensagem
                                            .substring(0, 20)
                                            .contains('uImage')
                                        ? 'imagem'
                                        : user
                                            .listRedes[index]
                                            .listMessages[user.listRedes[index]
                                                    .listMessages.length -
                                                1]
                                            .mensagem
                                            .substring(0, 20))
                                    : user
                                        .listRedes[index]
                                        .listMessages[user.listRedes[index]
                                                .listMessages.length -
                                            1]
                                        .mensagem
                                : '',
                            style: TextStyle(
                              color: currentTheme.isdark
                                  ? Colors.white.withOpacity(0.6)
                                  : Colors.black.withOpacity(0.6),
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                user.listRedes[index].listMessages.isNotEmpty
                                    ? user
                                        .listRedes[index]
                                        .listMessages[user.listRedes[index]
                                                .listMessages.length -
                                            1]
                                        .time
                                    : DateTime.now()
                                        .toString()
                                        .substring(0, 10)
                                        .replaceAll("-", "/"),
                                style: TextStyle(
                                  color: currentTheme.isdark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: CustomFloatingButton(
        controllerHost: controllerHost,
        controllerPorta: controllerPorta,
        user: user,
      ),
    );
  }
}
