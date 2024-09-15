import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/homepage.dart';
import 'package:quickwashers/Splash%20Screen/lets_go_in.dart';
import 'package:quickwashers/models/user_details.dart';
import 'package:quickwashers/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();

    // retrieveData();
    
    // _authService.setLocation(
    //     longitude: 6.6747, latitude: -1.5717, category: 'Home');
    // _authService.sendPasswordResetLink(phone: '0206452047');

    // Start a timer that will navigate to LoginPage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                currentUser.token == '' ? LetsGoIn() : const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 0, 153, 248),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 150,
              child: Image.asset('assets/images/LOGO.png'),
            ),
            const Text(
              'LAUNDRY BOWL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontFamily: 'HvDTrailBrandonText',
              ),
            ),
            const Spacer(),
            const Text(
              ' Let us take care of your laundry\nand have it delivered to you in 24hrs',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            Container(
              width: 908.0,
              height: 308.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/Splash 2 Screen Image 2.png'),
                    fit: BoxFit.cover),
              ),
              child: Image.asset('assets/images/Splash 2 Screen Image 2.png'),
            ),
          ],
        ), // Set the background color (white in this case)
        // Optionally add a centered logo or text here
      ),
    );
  }
}
