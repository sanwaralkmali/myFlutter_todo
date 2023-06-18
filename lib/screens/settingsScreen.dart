// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:my_todos/screens/components/space.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../styles/textStyle.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
  late bool isDarkMode = false;
  String fontFamily = 'Roboto';
  Color textColor = Colors.black;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH(16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Font Family: ',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                spaceW(32),
                DropdownButton<String>(
                  value: fontFamily,
                  hint: const Text('Select Font Family'),
                  onChanged: (newValue) {
                    setState(() {
                      fontFamily = newValue!;
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
              ],
            ),
          ),
          spaceH(16),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Row(
              children: [
                Text(
                  'Settings',
                  style: titleStyle.copyWith(
                    color: textColor,
                  ),
                ),
                spaceW(16),
                const Icon(
                  Icons.settings,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: 140.0,
              height: 2.0,
              child: Container(),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (newValue) {
              setState(() {
                isDarkMode = newValue;
              });
            },
          ),
          spaceH(16),
          TextButton(
            onPressed: () {
              _saveSettings();
              _restartApp(isDarkMode, fontFamily);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? darkModeValue = prefs.getBool('isDarkMode');
    String? fontFamilyValue = prefs.getString('fontFamily');

    setState(() {
      isDarkMode = darkModeValue!;
      fontFamily = fontFamilyValue!;
      isDarkMode ? textColor = Colors.white : textColor = Colors.black;
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
    prefs.setString('fontFamily', fontFamily);
    setState(() {
      textColor = isDarkMode ? Colors.white : Colors.black;
    });
  }

  void _restartApp(themeMode, fontFamily) {
    runApp(const MyApp(settingsExist: true));
  }
}
