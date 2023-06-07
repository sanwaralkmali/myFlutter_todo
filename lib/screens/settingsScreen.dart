// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Setting Screen',
      style: TextStyle(fontSize: 30),
    );
  }
}
