import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/homepage.dart';
import 'package:quickwashers/Login%20PAge/forgot_password_page.dart';
import 'package:quickwashers/OTP%20Verification/otpverificationpage.dart';
import 'package:quickwashers/SignUp%20Page/signuppage.dart';
import 'package:quickwashers/models/user_details.dart';

import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;
  String errorMessage = '';

  void login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final result = await authService.loginUser(
      role: 'customer',
      phone: phoneController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result['successful']) {
      // Navigate to OTP page
      // currentUser.token = result['token'];
      currentUser.retrieveData();
      Navigator.push(
          (context), MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      if (result['msg'] == "Account not verified") {
        currentUser.number = phoneController.text;
        Navigator.push(
            (context),
            MaterialPageRoute(
                builder: (context) => OTPVerificationPage(
                      phone: currentUser.number,
                    )));
      }
      setState(() {
        errorMessage = result['msg'];
      });
    }
  }

  void forgotPassword() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final result = await authService.sendPasswordResetEmail(
      phone: phoneController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (result['successful']) {
      // Navigate to OTP page
      Navigator.push((context),
          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
    } else {
      setState(() {
        errorMessage = result['msg'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                hintText: 'password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                const Text(
                  'Forgot',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      // forgotPassword();
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                    },
                    child: const Text(
                      'Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OTPVerificationPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            const Text('Or use socials', style: TextStyle(color: Colors.grey)),
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
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            // const SizedBox(height: 16.0),
            // isLoading
            //     ? const CircularProgressIndicator()
            //     : ElevatedButton(
            //         onPressed: login,
            //         child: const Text('Login'),
            //       ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
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
