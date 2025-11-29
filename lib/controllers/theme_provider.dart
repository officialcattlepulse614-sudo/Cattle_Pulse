import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeText = prefs.getString("themeMode");

    if (themeText == "dark") {
      _themeMode = ThemeMode.dark;
    } else if (themeText == "light") {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  void setTheme(ThemeMode mode) async {
    _themeMode = mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.dark) {
      prefs.setString("themeMode", "dark");
    } else if (mode == ThemeMode.light) {
      prefs.setString("themeMode", "light");
    } else {
      prefs.setString("themeMode", "system");
    }

    notifyListeners();
  }
}
