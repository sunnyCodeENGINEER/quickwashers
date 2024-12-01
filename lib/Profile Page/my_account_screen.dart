import 'package:flutter/material.dart';
import 'package:quickwashers/Profile%20Page/pages/terms_and_conditions_page.dart';
import 'package:quickwashers/Settings%20Page/settings_page.dart';
import 'package:quickwashers/Support%20Page/support_page.dart';
import 'package:quickwashers/models/user_details.dart';
import 'package:quickwashers/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late Future<UserDetail> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = loadUserProfile();
  }

  Future<UserDetail> loadUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      final user = await AuthService.fetchUserProfile();
      await user.storeData();
      return user;
    } else {
      return UserDetail(name: '', number: '', email: '', token: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'MY ACCOUNT',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: FutureBuilder<UserDetail>(
            future: userProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset('assets/images/image.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.number,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/SAVED ADDRESS.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Saved Addresses',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsAndConditionsPage()));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/TERMS AND CONDITIONS.png'),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SupportPage()));
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/images/entypo_chat.png'),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Support',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage()));
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/images/ion_settings.png'),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Settings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                  'assets/images/streamline_logout-1-solid.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            }));
  }
}
