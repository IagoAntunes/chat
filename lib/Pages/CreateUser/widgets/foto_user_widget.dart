import 'package:flutter/material.dart';

class FotoUser extends StatelessWidget {
  const FotoUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(
          Icons.camera_enhance_sharp,
          color: Colors.grey,
          size: 70,
        ),
      ),
    );
  }
}
