import 'package:flutter/material.dart';
import '../exportScreens.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
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
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month,
            size: 30,
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.upcoming,
            size: 30,
          ),
          label: 'Upcoming',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
          label: 'Settings',
        ),
      ],
      unselectedItemColor: Colors.black,
      selectedItemColor: const Color.fromARGB(196, 16, 85, 14),
      currentIndex: _index,
      onTap: (value) => navigate(value),
    );
  }
}
