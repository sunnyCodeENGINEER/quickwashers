import 'package:shared_preferences/shared_preferences.dart';

class UserDetail {
  String name;
  String number;
  String email;
  String token;

  UserDetail(
      {required this.name,
      required this.number,
      required this.email,
      required this.token});

  Future<void> storeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('number', number);
    await prefs.setString('email', email);
    await prefs.setString('token', token);
  }

  Future<void> retrieveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? counter = prefs.getInt('counter');
    name = prefs.getString('username') ?? '';
    number = prefs.getString('number') ?? '';
    email = prefs.getString('email') ?? '';
    token = prefs.getString('token') ?? '';

    print('number: $number');
    print('Username: $name');
    print('Token: $token');
  }

  Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

UserDetail currentUser = UserDetail(
  name: '',
  number: '',
  email: '',
  token: '',
);

Future<void> retrieveData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // int? counter = prefs.getInt('counter');
  currentUser.name = prefs.getString('username') ?? '';
  currentUser.number = prefs.getString('number') ?? '';
  currentUser.email = prefs.getString('email') ?? '';
  currentUser.token = prefs.getString('token') ?? '';

  print('number: ${currentUser.number}');
  print('Username: ${currentUser.name}');
  print('Token: ${currentUser.token}');
}

Future<void> storeData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', currentUser.name);
  await prefs.setString('number', currentUser.number);
  await prefs.setString('email', currentUser.email);
  await prefs.setString('token', currentUser.token);
}

Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

String pickUpLocation = 'Home';
String dropOffLocation = 'Home';
String pickUpTime = 'Home';
String dropOffTime = '';
