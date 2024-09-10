import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quickwashers/models/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://laundry-main-1.onrender.com/';

  // Function to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String role,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String repeatPassword,
  }) async {
    final url = Uri.parse('${baseUrl}api/auth/register');

    // Creating the request body
    final body = jsonEncode({
      'role': role,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'repeatPassword': repeatPassword,
    });

    print(body);

    // Making the POST request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    // Checking if the response status code is 201 (Created) or another status
    if (response.statusCode == 201) {
      // Decoding the successful response
      final responseData = jsonDecode(response.body);
      final newUser = responseData['newUser'];
      final phone = newUser['phone'];
      currentUser.number = phone;
      print('User phone: $phone');
      return {
        'successful': responseData['successful'],
        'msg': responseData['msg'],
        'newUser': responseData['newUser'],
      };
    } else {
      // Decoding the error response
      print('here');
      final responseData = jsonDecode(response.body);
      print(responseData.toString());
      return {
        'successful': false,
        'msg': responseData['msg'] ?? 'Registration failed',
      };
    }
  }

  // Login User
  Future<Map<String, dynamic>> loginUser({
    required String role,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('${baseUrl}api/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'role': role,
        'phone': phone,
        'password': password,
      }),
    );

    currentUser.number = phone;

    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Save token in shared preferences for persistent login
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', body['token']);
      return {
        'successful': true,
        'user': body['user'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }

  // Verify User
  Future<Map<String, dynamic>> verifyUser({
    required String phone,
    required String verificationCode,
  }) async {
    final url = Uri.parse('${baseUrl}api/auth/verify-account');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': phone,
        'verificationCode': verificationCode,
      }),
    );

    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // // Save token in shared preferences for persistent login
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', body['token']);
      return {
        'successful': true,
        'msg': body['msg'],
        'user': body['user'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }

  // Verify User
  Future<Map<String, dynamic>> resendCode() async {
    final url = Uri.parse('${baseUrl}api/auth/re-send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({
      //   'phone': phone,
      //   'verificationCode': verificationCode,
      // }),
    );

    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // // Save token in shared preferences for persistent login
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('token', body['token']);
      return {
        'successful': true,
        'msg': body['msg'],
        'newVerificationCode': body['newVerificationCode'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }

  // Get Stored Token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    return prefs.getString('token');
  }

  // Logout User
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
