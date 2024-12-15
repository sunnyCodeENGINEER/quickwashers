import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isSwitched = false;

  bool get isSwitched => _isSwitched;

  ThemeMode get currentTheme => _isSwitched ? ThemeMode.dark : ThemeMode.light;

  // Load theme preference from SharedPreferences
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isSwitched = prefs.getBool('isDarkMode') ?? false;
    print(_isSwitched);
    notifyListeners(); // Notify listeners after loading preferences
  }

  // Save theme preference to SharedPreferences
  Future<void> saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    _isSwitched = value;
    notifyListeners(); // Notify listeners after saving preference
  }
}
