import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Providers/theme_provider.dart';

import '../../../Config/config.dart';

class Head extends StatefulWidget {
  Head({Key? key, required this.value}) : super(key: key);

  ThemeProvider value;

  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Cria sua Conta:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: widget.value.isdark
                        ? Colors.white
                        : const Color(0xff333333),
                  ),
                ),
              ),
              Text(
                'Conversse com seus amigos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.value.isdark
                      ? Colors.grey
                      : const Color(0xff333333),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: (() {
              widget.value.switchTheme();
            }),
            icon: Icon(
              widget.value.isdark ? Icons.dark_mode : Icons.light_mode,
              color: widget.value.isdark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
