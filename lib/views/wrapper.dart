import 'package:flutter/material.dart';
import 'package:weather_app/providers/auth_provider.dart';
import 'package:weather_app/views/tabs/home_page.dart';
import 'package:weather_app/views/tabs/profile_page.dart';
import 'package:weather_app/views/tabs/settings_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: items.map((e) => e).toList(),
      ),
      body: getBody(_selectedIndex),
    );
  }
}

final List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
];

Widget getBody(int index) {
  switch (index) {
    case 0:
      return const HomePage();
    case 1:
      return const ProfilePage();
    case 2:
      return const SettingsPage();
    default:
      return const HomePage();
  }
}
