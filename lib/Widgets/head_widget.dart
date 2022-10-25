import 'package:flutter/material.dart';
import 'package:socketfront/Pages/config_page.dart';
import 'package:socketfront/config.dart';

class HeadWidget extends StatelessWidget {
  HeadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentTheme.isdark ? Color(0xff1C2D35) : Color(0xff075e55),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'WhatsApp',
                  style: TextStyle(
                    color:
                        currentTheme.isdark ? Color(0xffABABAB) : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
              padding: const EdgeInsets.only(top: 5),
              child: TabBar(
                labelColor:
                    currentTheme.isdark ? Color(0xff03AA82) : Colors.white,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4.0,
                    color:
                        currentTheme.isdark ? Color(0xff03AA82) : Colors.white,
                  ),
                ),
                unselectedLabelColor: currentTheme.isdark
                    ? Color(0xff8097A1)
                    : Colors.white.withOpacity(0.4),
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'CONVERSAS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'STATUS',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'CHAMADAS',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
