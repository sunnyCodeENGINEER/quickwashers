import 'package:flutter/material.dart';
import 'package:quickwashers/OTP%20Verification/otpverificationpage';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 246,
              child: Image.asset('assets/images/Splash 1 Screen Image 1.png'),
            ),
            const Text(
              'Password Recovery',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Please enter you phone number to\nrecover your password',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 328,
              child: TextField(),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OTPVerificationPage()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(140, 44),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
