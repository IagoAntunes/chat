import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../Config/config.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentTheme.isdark ? const Color(0xff121B22) : Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              height: 60,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xff008069),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.link,
                color: Colors.white,
              ),
            ),
            title: Text(
              'Create call link',
              style: TextStyle(
                color: currentTheme.isdark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'Share a link for you Whatsapp call',
              style: TextStyle(
                color: currentTheme.isdark ? Colors.grey : Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Recent',
              style: TextStyle(
                color: currentTheme.isdark ? Colors.grey : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xff03AA82),
        child: Icon(
          Icons.phone,
          color: currentTheme.isdark ? Colors.white : Colors.white,
        ),
      ),
    );
  }
}
