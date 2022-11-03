import 'package:flutter/material.dart';
import 'package:socketfront/Pages/Tab/whats_page.dart';
import 'package:socketfront/Pages/status_page.dart';
import 'package:socketfront/config.dart';

import '../Models/chat_model.dart';
import '../Widgets/head_widget.dart';

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
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: currentTheme.currentTheme(),
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: currentTheme.isdark ? Colors.green : Colors.white,
            ),
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
                      StatusPage(),
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
