import 'package:flutter/material.dart';

List getTheme(bool isDarkMode, String fontFamily) {
  return [
    ThemeData(
      primarySwatch: Colors.blue,
      primaryColor:
          isDarkMode ? Colors.black : const Color.fromARGB(199, 226, 222, 162),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
    ),
    isDarkMode ? ThemeMode.dark : ThemeMode.light,
    isDarkMode ? Colors.white : Colors.black26,
  ];
}
