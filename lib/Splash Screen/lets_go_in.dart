// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:quickwashers/Login%20PAge/loginpage.dart';
import 'package:quickwashers/SignUp%20Page/signuppage.dart';
import 'package:quickwashers/services/auth_service.dart';

class LetsGoIn extends StatefulWidget {
  LetsGoIn({super.key});

  String imagePath = 'assets/images/Laundry detergent.png';

  @override
  State<LetsGoIn> createState() => _LetsGoInState();
}

class _LetsGoInState extends State<LetsGoIn> {
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   widget.imagePath = 'assets/images/Washing.png';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Text('Let\'s get you in...'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              width: 197,
              height: 203,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.fitHeight,
                ),
              ),

              // child: Image.asset('assets/images/Laundry detergent.png')
            ),
            const Spacer(),
            const CustomLetsGoButton(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              label: 'Login',
              destination: LoginPage(),
            ),
            const CustomLetsGoButton(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 0, 153, 248),
              label: 'Signup',
              destination: SignUpPage(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomLetsGoButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final String label;
  final Widget destination;

  const CustomLetsGoButton({
    Key? key,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.label,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return ElevatedButton(
      onPressed: () {
        // print(authService.getToken().toString());
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
      child: SizedBox(width: 206, child: Center(child: Text(label))),
    );
  }
}
