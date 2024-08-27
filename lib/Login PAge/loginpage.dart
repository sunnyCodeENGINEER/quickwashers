import 'package:flutter/material.dart';
import 'package:quickwashers/OTP%20Verification/otpverificationpage';
import 'package:quickwashers/SignUp%20Page/signuppage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 150,
              color: Colors.blue.shade100,
              child: const Center(
                  child: Text('Image Placeholder',
                      style: TextStyle(color: Colors.white))),
            ),
            const SizedBox(height: 20),
            const Text(
              'LOGIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                hintText: 'GH +233 55 369 6305',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OTPVerificationPage()));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Continue'),
            ),
            const SizedBox(height: 20),
            const Text('Or use socials', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            _buildSocialLoginButton('Facebook', Colors.blue),
            _buildSocialLoginButton('Google', Colors.red),
            _buildSocialLoginButton('Apple', Colors.black),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: const Text(
                'New to us? REGISTER',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.login, color: Colors.white),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
