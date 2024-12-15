// import 'package:flutter/material.dart';
// import 'package:quickwashers/Theme%20Data/theme_data.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isSwitched = false;
//   bool isDarkMode = false;

//   ThemeMode _themeMode = ThemeMode.light;

//   void toggleTheme() {
//     setState(() {
//       themeMode =
//           themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     });
//   }

//   void loadPreferences() async {
//     // isSwitched = await loadThemePreference();
//     final prefs = await SharedPreferences.getInstance();
//     isSwitched = prefs.getBool('isDarkMode') ?? false;
//     print(isSwitched);
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       loadPreferences();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.chevron_left),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'SETTINGS',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Display Setting',
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Dark Mode',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'Experience an exciting dark mode',
//                         style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   Switch(
//                     value: isSwitched,
//                     activeColor: Colors.blue,
//                     inactiveThumbColor: Colors.white,
//                     onChanged: (value) {
//                       setState(() {
//                         isSwitched = value;
//                         setState(() {
//                           themeMode =
//                               !isSwitched ? ThemeMode.dark : ThemeMode.light;
//                         });

//                         toggleTheme();
//                         saveThemePreference(value);
//                       });
//                     },
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickwashers/Theme%20Data/theme_data.dart';
import 'package:quickwashers/Theme%20Data/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  // Load the saved theme preference from SharedPreferences
  void loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched =
          prefs.getBool('isDarkMode') ?? false; // Default to false if not found
    });
  }

  // Save the theme preference to SharedPreferences
  void saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  void initState() {
    super.initState();
    loadPreferences(); // Load the theme preference when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'SETTINGS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Display Setting',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dark Mode',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Experience an exciting dark mode',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Switch(
                      value: isSwitched,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          themeProvider.saveThemePreference(
                              value); // Save the theme preference

                          isSwitched = value; // Update the local state
                        });

                        // Save the new preference
                        saveThemePreference(value);

                        // Toggle theme mode based on switch value
                        if (isSwitched) {
                          // Dark mode
                          // Apply dark theme
                          themeMode = ThemeMode.dark;
                        } else {
                          // Light mode
                          // Apply light theme
                          themeMode = ThemeMode.light;
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
