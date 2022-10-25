import 'package:flutter/material.dart';
import 'package:socketfront/Pages/tab_page.dart';

import '../Models/chat_model.dart';
import '../Models/user_model.dart';
import '../config.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUser = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            currentTheme.isdark ? const Color(0xff333333) : Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cria sua Conta:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: currentTheme.isdark
                          ? Colors.white
                          : const Color(0xff333333),
                    ),
                  ),
                  IconButton(
                    onPressed: (() {
                      setState(() {
                        currentTheme.switchTheme();
                      });
                    }),
                    icon: Icon(
                      currentTheme.isdark ? Icons.dark_mode : Icons.light_mode,
                      color: currentTheme.isdark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Conversse com seus amigos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: currentTheme.isdark
                      ? Colors.grey
                      : const Color(0xff333333),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.camera_enhance_sharp,
                  color: Colors.grey,
                  size: 70,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: TextField(
                        controller: controllerUser,
                        style: TextStyle(
                          color:
                              currentTheme.isdark ? Colors.white : Colors.grey,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.grey,
                          ),
                          hintText: 'Usuario',
                          hintStyle: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: TextField(
                        controller: controllerDescription,
                        style: TextStyle(
                          color:
                              currentTheme.isdark ? Colors.white : Colors.grey,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.description,
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.grey,
                          ),
                          hintText: 'Descricao',
                          hintStyle: TextStyle(
                            color: currentTheme.isdark
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          if (controllerUser.text.isNotEmpty) {
                            User user = User(username: controllerUser.text);
                            Chat chat = Chat(user: user);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => TabBarDemo(
                                      chat: chat,
                                    )),
                              ),
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Next'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
