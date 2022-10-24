import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Pages/chat_page.dart';
import 'package:socketfront/Pages/create_group.dart';
import 'package:socketfront/config.dart';

class WhatsPage extends StatefulWidget {
  const WhatsPage({super.key});

  @override
  State<WhatsPage> createState() => _WhatsPageState();
}

class _WhatsPageState extends State<WhatsPage> {
  List<RedeModel> listRedes = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerPorta = TextEditingController();
    TextEditingController controllerHost = TextEditingController();

    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: listRedes.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>
                              MyHomePage(rede: listRedes[index])),
                        ),
                      ),
                      title: Text(
                        'Grupo 1',
                        style: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.black),
                      ),
                      leading: Icon(
                        Icons.group,
                        color:
                            currentTheme.isdark ? Colors.white : Colors.black,
                      ),
                      subtitle: const Text(
                        'Grupo 1',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Column(
                        children: const [
                          Text(
                            '14:00',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Hoje',
                            style: TextStyle(color: Colors.white),
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
          backgroundColor: Color(0xff1FBD68),
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
                                decoration: InputDecoration(
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
                                decoration: InputDecoration(
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
                                  );
                                  setState(() {
                                    listRedes.add(rede);
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
                                    builder: ((context) => CreateRoomPage()),
                                  ),
                                );
                                if (rede != null) {
                                  setState(() {
                                    listRedes.add(rede);
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
        ));
  }
}
