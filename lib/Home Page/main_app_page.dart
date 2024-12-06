import 'package:flutter/material.dart';
import 'package:quickwashers/Home%20Page/homepage.dart';
import 'package:quickwashers/Orders%20Page/my_orders_page.dart';
import 'package:quickwashers/Profile%20Page/my_account_screen.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const MyOrdersPage(),
    const MyAccountScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/elements (1).png',
                color: _currentIndex == 0 ? Colors.blue : Colors.grey,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/Order Icon.png',
                color: _currentIndex == 1 ? Colors.blue : Colors.grey,
              ),
              label: 'Orders'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/user Icon.png',
                color: _currentIndex == 2 ? Colors.blue : Colors.grey,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
