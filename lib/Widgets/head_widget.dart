import 'package:flutter/material.dart';
import 'package:socketfront/Pages/config_page.dart';
import 'package:socketfront/config.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: currentTheme.isdark ? Color(0xff333333) : Color(0xff1FBD68)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WhatsApp',
                  style: TextStyle(
                      color: currentTheme.isdark
                          ? Color(0xffABABAB)
                          : Colors.white,
                      fontSize: 24),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: currentTheme.isdark
                          ? Color(0xffABABAB)
                          : Colors.white,
                    ),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 2.0, color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => ConfigPage()),
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
                        PopupMenuItem<dynamic>(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Configurações'),
                              Icon(Icons.toll_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Conversas',
                      style: TextStyle(
                        color: currentTheme.isdark
                            ? Color(0xffABABAB)
                            : Colors.white,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Stories',
                      style: TextStyle(
                        color: currentTheme.isdark
                            ? Color(0xffABABAB)
                            : Colors.white,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Chamadas',
                      style: TextStyle(
                        color: currentTheme.isdark
                            ? Color(0xffABABAB)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
