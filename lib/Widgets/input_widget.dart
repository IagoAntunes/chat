import 'package:flutter/material.dart';

import '../Config/config.dart';

class CustomInput extends StatelessWidget {
  CustomInput(
      {Key? key,
      required this.controllerDescription,
      required this.hintText,
      required this.icon,
      required this.value})
      : super(key: key);

  final TextEditingController controllerDescription;
  IconData icon;
  String? hintText;
  bool value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: TextField(
        controller: controllerDescription,
        style: TextStyle(
          color: value ? Colors.white : Colors.grey,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: value ? Colors.white : Colors.grey,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: value ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
