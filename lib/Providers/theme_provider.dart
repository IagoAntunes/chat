import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  get isdark {
    return _isDark;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
