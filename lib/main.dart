import 'package:flutter/material.dart';
import 'package:quickwashers/Splash%20Screen/splashscreen.dart';
import 'package:quickwashers/Theme%20Data/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'HvDTrialBrandonText'
          ),
      darkTheme: darkTheme,
      
      home: const SplashScreen(),
      
    );
  }
}
