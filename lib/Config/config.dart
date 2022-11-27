library config.globals;

import 'package:socketfront/Providers/chat_provider.dart';
import 'package:socketfront/Providers/theme_provider.dart';
import 'package:socketfront/Providers/user_provider.dart';

ThemeProvider currentTheme = ThemeProvider();
UserProvider userProv = UserProvider();
ChatProvider chatProv = ChatProvider();

List<int> listColors = [
  0xff0000ff,
  0xffff0000,
  0xffffcbdb,
  0xff993399,
  0xffffa500,
  0xffffff00
];
List<String> listImages = [
  "https://cdn-icons-png.flaticon.com/512/3940/3940417.png",
  "https://cdn-icons-png.flaticon.com/512/4139/4139981.png",
  "https://cdn-icons-png.flaticon.com/512/6997/6997662.png"
];

double defaultPadding = 8.0;
