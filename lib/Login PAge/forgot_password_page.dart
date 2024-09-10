import 'package:flutter/material.dart';
import 'package:quickwashers/OTP%20Verification/otpverificationpage.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 246,
              child: Image.asset('assets/images/Splash 1 Screen Image 1.png'),
            ),
            const Text(
              'Password Recovery',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Please enter you phone number to\nrecover your password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 328,
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: 'GH +233 55 369 6305',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OTPVerificationPage(phone: phoneController.text,)),
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
