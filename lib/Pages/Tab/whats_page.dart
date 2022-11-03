import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Pages/chat_page.dart';
import 'package:socketfront/Pages/create_group.dart';
import 'package:socketfront/config.dart';

import '../../Models/user_model.dart';

class WhatsPage extends StatefulWidget {
  const WhatsPage({super.key});

  @override
  State<WhatsPage> createState() => _WhatsPageState();
}

class _WhatsPageState extends State<WhatsPage> {
  User user = userProv.getUser;
  List<RedeModel> listRedes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerPorta = TextEditingController();
    TextEditingController controllerHost = TextEditingController();

    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: user.listRedes.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () => Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: ((context) =>
                            MyHomePage(rede: user.listRedes[index])),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    }),
                    title: Text(
                      'Grupo 1',
                      style: TextStyle(
                          color: currentTheme.isdark
                              ? Colors.white
                              : Colors.black),
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.group,
                          color:
                              currentTheme.isdark ? Colors.white : Colors.black,
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
                              ? user
                                  .listRedes[index]
                                  .listMessages[user.listRedes[index]
                                          .listMessages.length -
                                      1]
                                  .mensagem
                                  .substring(0, 20)
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
                          '14:00',
                          style: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          'Hoje',
                          style: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03AA82),
        child: Icon(
          Icons.chat,
          color: currentTheme.isdark ? Colors.white : Colors.white,
        ),
        onPressed: (() async {
          showDialog(
            context: context,
            builder: ((context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //Conteudo
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Titulo
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Grupo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: TextField(
                              controller: controllerHost,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'HOST',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: TextField(
                              controller: controllerPorta,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'PORTA',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                            ),
                          ),

                          GestureDetector(
                            onTap: (() {
                              if (controllerPorta.text.isNotEmpty &&
                                  controllerHost.text.isNotEmpty) {
                                RedeModel rede = RedeModel(
                                    porta: int.parse(controllerPorta.text),
                                    host: controllerHost.text,
                                    listMessages: [],
                                    usersOnline: []);
                                setState(() {
                                  user.listRedes.add(rede);
                                });
                                Navigator.pop(context, rede);
                              }
                            }),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Entrar Sala',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() async {
                              RedeModel? rede =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      const CreateRoomPage()),
                                ),
                              );
                              if (rede != null) {
                                setState(() {
                                  user.listRedes.add(rede);
                                });
                                print(rede.host);
                              }
                            }),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Criar Sala',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
          backgroundColor:
          const Color(0xffABABAB);
          child:
          const Icon(
            Icons.message_rounded,
            color: Color(0xff2B2B2B),
          );
        }),
        //   onPressed: ((() => showDialog(
        //         context: context,
        //         builder: ((context) {
        //           return Dialog(
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20)),
        //             child: Stack(
        //               alignment: Alignment.center,
        //               children: [
        //                 //Conteudo
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: [
        //                       //Titulo
        //                       const Padding(
        //                         padding: EdgeInsets.symmetric(vertical: 10),
        //                         child: Text(
        //                           'Grupo',
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 18,
        //                           ),
        //                         ),
        //                       ),
        //                       Container(
        //                         decoration: BoxDecoration(
        //                           border: Border.all(width: 1),
        //                           borderRadius: const BorderRadius.all(
        //                             Radius.circular(20),
        //                           ),
        //                         ),
        //                         child: TextField(
        //                           controller: controllerHost,
        //                           decoration: InputDecoration(
        //                               border: InputBorder.none,
        //                               hintText: 'HOST',
        //                               contentPadding:
        //                                   EdgeInsets.symmetric(horizontal: 20)),
        //                         ),
        //                       ),
        //                       const SizedBox(height: 10),
        //                       Container(
        //                         decoration: BoxDecoration(
        //                           border: Border.all(width: 1),
        //                           borderRadius: const BorderRadius.all(
        //                             Radius.circular(20),
        //                           ),
        //                         ),
        //                         child: TextField(
        //                           controller: controllerPorta,
        //                           decoration: InputDecoration(
        //                               border: InputBorder.none,
        //                               hintText: 'PORTA',
        //                               contentPadding:
        //                                   EdgeInsets.symmetric(horizontal: 20)),
        //                         ),
        //                       ),
        //                       GestureDetector(
        //                         onTap: (() {
        //                           if (controllerPorta.text.isNotEmpty &&
        //                               controllerHost.text.isNotEmpty) {
        //                             RedeModel rede = RedeModel(
        //                               porta: int.parse(controllerPorta.text),
        //                               host: controllerHost.text,
        //                               listMessages: [],
        //                             );
        //                             setState(() {
        //                               listRedes.add(rede);
        //                             });
        //                             Navigator.pop(context, rede);
        //                           }
        //                         }),
        //                         child: Padding(
        //                           padding: const EdgeInsets.only(top: 15),
        //                           child: Container(
        //                             decoration: BoxDecoration(
        //                               border: Border.all(
        //                                 width: 1,
        //                               ),
        //                               borderRadius: const BorderRadius.all(
        //                                 Radius.circular(10),
        //                               ),
        //                             ),
        //                             child: const Padding(
        //                               padding: EdgeInsets.all(8.0),
        //                               child: Text(
        //                                 'Entrar Sala',
        //                                 textAlign: TextAlign.center,
        //                                 style: TextStyle(
        //                                   fontWeight: FontWeight.w500,
        //                                   letterSpacing: 5,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Positioned(
        //                   top: 0,
        //                   right: 0,
        //                   child: IconButton(
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     icon: const Icon(Icons.close),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //         }),
        //       ))),
        //   backgroundColor: const Color(0xffABABAB),
        //   child: const Icon(
        //     Icons.message_rounded,
        //     color: Color(0xff2B2B2B),
        //   ),
        // ),
      ),
    );
  }
}
