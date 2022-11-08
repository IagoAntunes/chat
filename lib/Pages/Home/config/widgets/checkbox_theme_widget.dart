import 'package:flutter/material.dart';

import '../../../../Config/config.dart';

class CheckBoxTheme extends StatefulWidget {
  CheckBoxTheme({
    Key? key,
    required this.isChecked,
  }) : super(key: key);

  bool isChecked;

  @override
  State<CheckBoxTheme> createState() => _CheckBoxThemeState();
}

class _CheckBoxThemeState extends State<CheckBoxTheme> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Icon(
            currentTheme.isdark ? Icons.dark_mode : Icons.light_mode,
            color: currentTheme.isdark ? Colors.white : Colors.black,
          ),
          Checkbox(
            fillColor: MaterialStateProperty.all(
                currentTheme.isdark ? Colors.white : Colors.black),
            value: widget.isChecked,
            onChanged: ((value) {
              setState(
                () {
                  currentTheme.switchTheme();
                  widget.isChecked = !widget.isChecked;
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
