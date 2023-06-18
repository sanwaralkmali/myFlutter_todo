// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exportScreens.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  late Color iconColor = const Color.fromARGB(255, 0, 0, 0);
  late Color labelColor = const Color.fromARGB(255, 42, 125, 60);
  late bool isDarkMode = false;

  final List<Widget> _screens = const <Widget>[
    HomeScreen(),
    HistoryScreen(),
    UpcomingScreen(),
    SettingsScreen(),
  ];

  void navigate(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 25,
      ),
      body: _screens.elementAt(_index),
      bottomNavigationBar: myBottomNavigationBar(),
    );
  }

  BottomNavigationBar myBottomNavigationBar() {
    _loadSettings();
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: isDarkMode
                ? const Color.fromARGB(255, 222, 217, 217)
                : const Color.fromARGB(255, 36, 35, 35),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month,
            size: 30,
            color: isDarkMode
                ? const Color.fromARGB(255, 222, 217, 217)
                : const Color.fromARGB(255, 36, 35, 35),
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.upcoming,
            size: 30,
            color: isDarkMode
                ? const Color.fromARGB(255, 222, 217, 217)
                : const Color.fromARGB(255, 36, 35, 35),
          ),
          label: 'Upcoming',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 30,
            color: isDarkMode
                ? const Color.fromARGB(255, 222, 217, 217)
                : const Color.fromARGB(255, 36, 35, 35),
          ),
          label: 'Settings',
        ),
      ],
      selectedItemColor: isDarkMode
          ? const Color.fromARGB(228, 124, 218, 110)
          : const Color.fromARGB(241, 24, 133, 16),
      currentIndex: _index,
      onTap: (value) => navigate(value),
    );
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }
}
