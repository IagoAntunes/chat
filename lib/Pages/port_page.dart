import 'package:flutter/material.dart';

class PortPage extends StatelessWidget {
  const PortPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerHost = TextEditingController();
    TextEditingController controllerPorta = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            Navigator.of(context).pop();
          }),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Digita Ai :P',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: controllerHost,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'HOST',
                          hintStyle: TextStyle(fontSize: 32),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                      TextField(
                        controller: controllerPorta,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'PORTA',
                          hintStyle: TextStyle(fontSize: 32),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 5,
                    )),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Salvar',
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
    );
  }
}
