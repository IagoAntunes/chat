import 'package:flutter/material.dart';
import 'package:socketfront/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Iago'),
            subtitle: Text('Teste teste teste'),
          ),
          Row(
            children: [
              Icon(currentTheme.isdark ? Icons.dark_mode : Icons.light_mode),
              Checkbox(
                value: isChecked,
                onChanged: ((value) => setState(() {
                      currentTheme.switchTheme();
                    })),
              ),
            ],
          )
        ],
      ),
    );
  }
}
