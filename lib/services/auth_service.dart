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

  // Resend code
  Future<Map<String, dynamic>> resendCode() async {
    final url = Uri.parse('${baseUrl}api/auth/re-send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
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

  Future<Map<String, dynamic>> sendPasswordResetLink(
      {required String phone}) async {
    final url = Uri.parse('${baseUrl}api/auth/send-password-reset-email');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${currentUser.token}',
        },
        body: jsonEncode({'phone': phone}));

    print(response.statusCode);
    print(response.body);
    print(response.body);
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'successful': true,
        'msg': body['msg'],
      };
    } else {
      return {
        'successful': false,
        'msg': body['msg'],
      };
    }
  }

  Future<Map<String, dynamic>> sendPasswordResetEmail({
    required String phone,
  }) async {
    final url = Uri.parse(
        'https://laundry-main-1.onrender.com/api/auth/send-password-reset-email');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${currentUser.token}',
            },
            body: jsonEncode({
              'phone': phone,
            }),
          )
          .timeout(
              const Duration(seconds: 10)); // Timeout to prevent long waits

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // If the response is successful, return a success message
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return {
          'successful': true,
          'msg': body['msg'],
        };
      }
      // If user is not found
      else if (response.statusCode == 404) {
        final body = jsonDecode(response.body);
        return {
          'successful': false,
          'msg': body['msg'] ?? 'User not found',
        };
      }
      // Handle server errors
      else if (response.statusCode == 500) {
        final body = jsonDecode(response.body);
        return {
          'successful': false,
          'msg': body['msg'] ?? 'Server error',
        };
      } else {
        // Handle any other unexpected response
        return {
          'successful': false,
          'msg': 'Unexpected error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'successful': false,
        'msg': 'Request failed: ${e.toString()}',
      };
    }
  }

  // Future<Map<String, dynamic>> setLocation(
  //     {required double longitude,
  //     required double latitude,
  //     required String category}) async {
  //   final url = Uri.parse('${baseUrl}api/location/set');

  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${currentUser.token}',
  //     },
  //     body: jsonEncode({
  //       'longitude': longitude,
  //       'latitude': latitude,
  //       'category': category,
  //     }),
  //   );

  //   print(response.body);
  //   print('================');
  //   final body = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     return {
  //       'successful': true,
  //       'msg': body['msg'],
  //       'location': body['location'],
  //     };
  //   } else {
  //     return {
  //       'successful': false,
  //       'msg': body['msg'],
  //     };
  //   }
  // }

  Future<Map<String, dynamic>> setLocation({
    required double longitude,
    required double latitude,
    required String category,
    required String token,
  }) async {
    try {
      final url = Uri.parse('${baseUrl}api/location/set');

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer $token',
            },
            body: jsonEncode({
              'longitude': longitude,
              'latitude': latitude,
              'category': category,
            }),
          )
          .timeout(
              const Duration(seconds: 10)); // Adding a timeout of 10 seconds

      print(response.statusCode);
      print(response.body);
      print(url);
      print('================');

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'successful': true,
          'msg': body['msg'],
          'location': body['location'],
        };
      } else {
        return {
          'successful': false,
          'msg': body['msg'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      return {
        'successful': false,
        'msg': 'Request failed: ${e.toString()}',
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
