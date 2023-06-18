// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:my_todos/exportScreens.dart';
import 'package:my_todos/screens/components/space.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomingScreen extends StatefulWidget {
  const WelcomingScreen({super.key});

  @override
  _WelcomingScreenState createState() => _WelcomingScreenState();
}

class _WelcomingScreenState extends State<WelcomingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _saveSettingsAndNavigate(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Transform.translate(
                      offset: Offset(0, -100 + (_animation.value * 100)),
                      child: const Text(
                        'Welcome to ToDoHub - your personal task management companion!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Montserrat Alternates',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: 15,
              bottom: 15,
              child: TextButton(
                onPressed: () => _saveSettingsAndNavigate(context),
                child: const Text('Skip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedFontFamily = 'Roboto';
  bool _isDarkMode = false;
  bool _isNotificationEnabled = false;

  final List<String> _fontFamilies = [
    'Ubuntu',
    'Roboto',
    'Arial',
    'Courier',
    'Raleway',
    'Montserrat Alternates',
    'Montserrat',
    'Bebas Neue',
    'Caveat',
    'Chakra Petch',
    'Dancing Script',
    'Josefin Sans',
    'Lato',
    'Kablammo',
    'Lobster',
    'Source Sans Pro',
    'Source Code Pro',
    'Tilt Prism',
    'Titllium Web'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedFontFamily,
            hint: const Text(
              'Select Font',
            ),
            onChanged: (newValue) {
              setState(() {
                _selectedFontFamily = newValue!;
              });
            },
            items: _fontFamilies.map((font) {
              return DropdownMenuItem<String>(
                value: font,
                child: Text(
                  font,
                  style: TextStyle(
                    fontFamily: font,
                  ),
                ),
              );
            }).toList(),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (newValue) {
              setState(() {
                _isDarkMode = newValue;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _isNotificationEnabled,
            onChanged: (newValue) {
              setState(() {
                _isNotificationEnabled = newValue;
              });
            },
          ),
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              // Save selected settings
              await prefs.setString('fontFamily', _selectedFontFamily);
              await prefs.setBool('isDarkMode', _isDarkMode);
              await prefs.setBool(
                  'isNotificationEnabled', _isNotificationEnabled);

              // Navigate to user information screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const UserInfoScreen()),
              );
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool showWarning = false;
  String userName = '';
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => setState(
                () {
                  userName = value;
                },
              ),
            ),
            spaceH(8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => setState(
                () {
                  userEmail = value;
                },
              ),
            ),
            spaceH(12),
            if (showWarning)
              const Text(
                'Please enter you name and email! ',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            spaceH(16),
            ElevatedButton(
              onPressed: () async {
                if (userName.isEmpty || userEmail.isEmpty) {
                  setState(() {
                    showWarning = true;
                  });
                  return;
                }

                SharedPreferences prefs = await SharedPreferences.getInstance();

                // Save user information
                await prefs.setString('name', _nameController.text);
                await prefs.setString('email', _emailController.text);

                // Navigate to the last screen before the home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const FinalScreen()),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Final Screen')),
      body: Center(
        child: Stack(children: [
          Column(
            children: [
              InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(6),
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.asset(
                  'assets/help/help1.png',
                ),
              ),
            ],
          ),
          Positioned(
            right: 15,
            bottom: 15,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyHomePage(
                      title: 'My Todos',
                    ),
                  ),
                );
              },
              child: const Text('Start'),
            ),
          ),
        ]),
      ),
    );
  }
}
