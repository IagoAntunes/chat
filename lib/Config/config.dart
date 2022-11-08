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

double defaultPadding = 8.0;
