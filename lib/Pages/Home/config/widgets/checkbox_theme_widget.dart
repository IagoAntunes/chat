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
            color: currentTheme.isdark ? Colors.white : Colors.grey,
          ),
          Checkbox(
            fillColor: MaterialStateProperty.all(Color(0xff03AA82)),
            value: currentTheme.isdark ? true : false,
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
