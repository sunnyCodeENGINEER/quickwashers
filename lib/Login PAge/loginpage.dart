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
        title: const Row(
          children: [Spacer(), Text('Welcome Back'), Spacer()],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
         child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 192,
                child: Center(
                  child: Image.asset('assets/images/LOGIN PAGE IMAGE.png'),
                ),
              ),
              const SizedBox(height: 20),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Or use socials',
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              // CustomSocialButton('Facebook', Colors.blue),
              const CustomSocialButton(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  label: "assets/images/GOOGLE BUTTON.png",
                  destination: Placeholder()),
              const CustomSocialButton(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  label: "assets/images/APPLE BUTTON.png",
                  destination: Placeholder()),
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
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          
        ),
      ),
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final String label;
  final Widget destination;

  const CustomSocialButton({
    Key? key,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.label,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: SizedBox(
        width: 206,
        child: Center(
            child: Image.asset(
          label,
          fit: BoxFit.fitWidth,
        )
            //  Text(label),
            ),
      ),
    );
  }
}
