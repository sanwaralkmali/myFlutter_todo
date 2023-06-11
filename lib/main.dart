import 'package:flutter/material.dart';
import './screens/home.dart' show MyHomePage;
import 'db/database_helper.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.initializeDatabase();

    return MaterialApp(
      title: 'My TODOs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
        fontFamily: 'Ubuntu',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(
        title: "Today's To",
      ),
    );
  }
}
