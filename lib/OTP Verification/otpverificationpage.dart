import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickwashers/Login%20PAge/loginpage.dart';
import 'package:quickwashers/services/auth_service.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phone;
  final bool reset;
  const OTPVerificationPage(
      {super.key, required this.phone, this.reset = false});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  String errorMessage = '';

  bool isLoading = false;

  // Store the OTP in this variable
  String _verificationCode = '';

  // Create controllers for each TextField
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    // Dispose all controllers and focus nodes when not needed
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      // Move to the next field if input is made
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus(); // Last field, so unfocus
      }
    } else {
      // When a digit is deleted
      if (index > 0) {
        FocusScope.of(context).requestFocus(
            _focusNodes[index - 1]); // Move back to the previous field
      }
    }

    // Concatenate all text fields to form the complete OTP
    _verificationCode =
        _controllers.map((controller) => controller.text).join();
    print('OTP Code: $_verificationCode');
  }

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
          phone: widget.phone, verificationCode: _verificationCode);

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

  void _setNewPassword() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (validateFields()) {
      final result = await _authService.resetPassword(
          verificationCode: _code.text, newPassword: _newPassword.text);

      if (result['successful']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful!')),
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    onChanged: (value) => _onChanged(index, value),
                    onSubmitted: (_) {
                      // Prevent focus on Enter/Submit
                      FocusScope.of(context).unfocus();
                    },
                    // Handle backspace by detecting key press
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                  ),
                );
              }),
            ),
            // TextField(
            //   controller: _code,
            // ),
            !widget.reset
                ? Container()
                : TextField(
                    controller: _newPassword,
                    obscureText: true,
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

                  widget.reset ? _setNewPassword() : _verify();
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
