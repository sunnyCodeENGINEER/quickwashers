import 'package:flutter/material.dart';
import 'package:quickwashers/Login%20PAge/loginpage.dart';
import 'package:quickwashers/services/auth_service.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phone;
  const OTPVerificationPage({
    super.key,
    required this.phone,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _code = TextEditingController();
  String errorMessage = '';

  bool isLoading = false;

  // function to make sure all fields are filled
  bool validateFields() {
    return true;
  }

  // Function to handle the sign-up process
  void _verify() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (validateFields()) {
      final result = await _authService.verifyUser(
          phone: widget.phone, verificationCode: _code.text);

      if (result['successful']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification successful!')),
        );
        // Navigate to OTP page
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
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
      appBar: AppBar(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: Center(
                  child: Image.asset('assets/images/OTP SCREEN IMAGE.png')),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter OTP Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the verification code sent to\nthe given number',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOTPBox(),
                _buildOTPBox(),
                _buildOTPBox(),
                _buildOTPBox(),
                _buildOTPBox(),
                _buildOTPBox(),
              ],
            ),
            TextField(
              controller: _code,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't get code? "),
                GestureDetector(
                  onTap: () {
                    _authService.resendCode();
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                const Text(
                  '0:30s',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 30),
            Row(children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // print(getToken());
                  // authService.verifyUser(
                  //     phone: currentUser.number, verificationCode: _code.text);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  //   (Route<dynamic> route) => false,
                  // );
                  print(_code.text);

                  _verify();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 44),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: const Text('Continue'),
              ),
              const Spacer()
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox() {
    return SizedBox(
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
