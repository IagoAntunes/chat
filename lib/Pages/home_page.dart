import 'package:flutter/material.dart';
import 'package:socketfront/Pages/name_page.dart';
import 'package:socketfront/Pages/port_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: SizedBox(
                height: 400,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => PortPage()),
                          ),
                        );
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 5,
                        )),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Entrar Sala',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => NamePage()),
                          ),
                        );
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Alterar Nome',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
