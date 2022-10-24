import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socketfront/Pages/home_page.dart';
import 'package:socketfront/Pages/Tab/whats_page.dart';
import 'package:socketfront/config.dart';

import '../Widgets/head_widget.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatefulWidget {
  TabBarDemo({super.key});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      print('Change Theme');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: currentTheme.currentTheme(),
      theme: ThemeData(
        primaryColorLight: Colors.green,
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                color: currentTheme.isdark ? Colors.green : Colors.blue),
          ),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                HeadWidget(),
                Expanded(
                  child: TabBarView(
                    children: [
                      WhatsPage(),
                      Icon(Icons.directions_bike),
                      Column(
                        children: [
                          Icon(
                            Icons.call,
                            size: 120,
                          ),
                          Text('Sem Chamadas!')
                        ],
                      ),
                    ],
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
