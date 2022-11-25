import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Pages/CreateUser/create_user_page.dart';
import 'package:socketfront/Providers/chat_provider.dart';
import 'package:socketfront/Providers/theme_provider.dart';

import 'Providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socket Chat',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColorLight: Colors.green,
      ),
      home: const CreateUserPage(),
    );
  }
}
