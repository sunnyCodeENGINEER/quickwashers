import 'package:flutter/material.dart';
import 'package:quickwashers/services/auth_service.dart';

import '../OTP Verification/otpverificationpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  // final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  String role = 'customer';

  bool isLoading = false;

  // function to make sure all fields are filled
  bool validateFields() {
    return true;
  }

  // Function to handle the sign-up process
  void _register() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (validateFields()) {
      // _formKey.currentState!.save();

      final result = await _authService.registerUser(
        role: 'customer',
        name: _nameController.text,
        email: _emailController.text,
        phone: _numberController.text,
        password: _passwordController.text,
        repeatPassword: _passwordController.text,
      );

      if (result['successful']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Registration successful! Please verify your email.')),
        );
        // Navigate to OTP page
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => OTPVerificationPage(
              phone: _numberController.text,
            ),
          ),
        );
      } else {
        setState(() {
          errorMessage = result['msg'];
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, nice to\nmeet you.',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Fill the details below to get started.'),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/images/circle-password.png'),
                  hintText: 'Create a password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _repeatPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Image.asset('assets/images/circle-password.png'),
                  hintText: 'Repeat your password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('We’ll send verification code to the above number'),
            const SizedBox(height: 20),
            Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          _register();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          // minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Continue'),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' LOGIN',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
