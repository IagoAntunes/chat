import 'package:flutter/material.dart';
import 'package:socketfront/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff0F1C24) : Colors.white,
      appBar: AppBar(
        backgroundColor: currentTheme.isdark
            ? const Color(0xff1C2D35)
            : const Color(0xff1FBD68),
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: currentTheme.isdark ? Colors.white : Colors.black,
            ),
            title: Text(
              'Iago',
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Text(
              'Teste teste teste',
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                currentTheme.isdark ? Icons.dark_mode : Icons.light_mode,
                color: currentTheme.isdark ? Colors.white : Colors.black,
              ),
              Checkbox(
                fillColor: MaterialStateProperty.all(
                    currentTheme.isdark ? Colors.white : Colors.black),
                value: isChecked,
                onChanged: ((value) => setState(() {
                      currentTheme.switchTheme();
                      isChecked = !isChecked;
                    })),
              ),
            ],
          )
        ],
      ),
    );
  }
}
