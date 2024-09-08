class User {
  String token = '';
  final String role;
  final String name;
  final String email;
  final String phone;

  User({
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
  });
}
