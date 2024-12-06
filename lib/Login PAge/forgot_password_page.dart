import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickwashers/OTP%20Verification/otpverificationpage.dart';
import 'package:quickwashers/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService _authService = AuthService();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  late Timer _timer;
  int _remainingSeconds = 30;

 

  void forgotPassword() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final result = await _authService.sendPasswordResetLink(
      phone: phoneController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result['successful']) {
      // Navigate to OTP page
      Navigator.push(
        (context),
        MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
                  phone: phoneController.text,
                  reset: true,
                )),
      );
    } else {
      setState(() {
        errorMessage = result['msg'];
      });
    }
  }

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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    hintText: 'GH +233 55 369 6305',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : ElevatedButton(
                    onPressed: () {
                      forgotPassword();
                      // _authService.sendPasswordResetLink(phone: phoneController.text);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => OTPVerificationPage(
                      //             phone: phoneController.text,
                      //             reset: true,
                      //           )),
                      // (Route<dynamic> route) => false,
                      // );
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
