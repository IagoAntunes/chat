import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Providers/user_provider.dart';

import '../../../../Models/rede_model.dart';
import '../../../../Models/user_model.dart';
import '../../../../Config/config.dart';
import '../../../create_group.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({
    Key? key,
    required this.controllerHost,
    required this.controllerPorta,
    required this.user,
  }) : super(key: key);

  final TextEditingController controllerHost;
  final TextEditingController controllerPorta;
  final User user;

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff03AA82),
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
                            controller: widget.controllerHost,
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
                            controller: widget.controllerPorta,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'PORTA',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20)),
                          ),
                        ),

                        GestureDetector(
                          onTap: (() {
                            if (widget.controllerPorta.text.isNotEmpty &&
                                widget.controllerHost.text.isNotEmpty) {
                              RedeModel rede = RedeModel(
                                  porta: int.parse(widget.controllerPorta.text),
                                  host: widget.controllerHost.text,
                                  listMessages: [],
                                  usersOnline: []);
                              setState(() {
                                widget.user.listRedes.add(rede);
                              });
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(widget.user);
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
                            RedeModel? rede = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const CreateRoomPage()),
                              ),
                            );
                            if (rede != null) {
                              setState(() {
                                widget.user.listRedes.add(rede);
                              });
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUser(widget.user);
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
      }),
      child: Icon(
        Icons.chat,
        color: currentTheme.isdark ? Colors.white : Colors.white,
      ),
    );
  }
}
