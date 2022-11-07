import 'package:flutter/material.dart';
import 'package:socketfront/Models/rede_model.dart';
import 'package:socketfront/Config/config.dart';

class OnlinePage extends StatelessWidget {
  const OnlinePage({super.key, required this.rede});
  final RedeModel rede;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentTheme.isdark
            ? const Color(0xff1C2D35)
            : const Color(0xff075e55),
        title: const Text('Pessoas Online'),
      ),
      backgroundColor: currentTheme.isdark
          ? const Color(0xff0F1C24)
          : const Color.fromARGB(255, 237, 238, 190),
      body: ListView.builder(
        itemCount: rede.usersOnline!.length,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: const Icon(
              Icons.circle,
              color: Colors.green,
            ),
            title: Text(
              rede.usersOnline![index].user,
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}
