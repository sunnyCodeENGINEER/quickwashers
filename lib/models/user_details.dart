import 'package:shared_preferences/shared_preferences.dart';

class UserDetail {
  String name;
  String number;
  // final String email;
  String token;

  UserDetail({required this.name, required this.number, required this.token});

  Future<void> storeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('number', number);
    await prefs.setString('token', token);
  }

  Future<void> retrieveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? counter = prefs.getInt('counter');
    name = prefs.getString('username') ?? '';
    number = prefs.getString('number') ?? '';
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
  token: '',
);

Future<void> retrieveData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // int? counter = prefs.getInt('counter');
  currentUser.name = prefs.getString('username') ?? '';
  currentUser.number = prefs.getString('number') ?? '';
  currentUser.token = prefs.getString('token') ?? '';

  print('number: ${currentUser.number}');
  print('Username: ${currentUser.name}');
  print('Token: ${currentUser.token}');
}
