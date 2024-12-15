import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickwashers/Splash%20Screen/splashscreen.dart';
import 'package:quickwashers/Theme%20Data/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Theme Data/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isSwitched = false;

  // Load the saved theme preference from SharedPreferences
  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched =
          prefs.getBool('isDarkMode') ?? false; // Default to false if not found
    });
  }

  // Save the theme preference to SharedPreferences
  void saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  void initState() {
    super.initState();
    loadPreferences(); // Load the theme preference when the app starts
    ThemeProvider().loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider()
        ..loadPreferences(), // Load preferences when the app starts
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true,
                fontFamily: 'HvDTrialBrandonText'),
            darkTheme: darkTheme,
            themeMode: themeProvider.currentTheme,
            // themeMode: isSwitched ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
