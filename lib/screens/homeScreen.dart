// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import './components/todo_item_widget.dart';
import '../data/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  ToDoItem first_item = ToDoItem(
    title: 'My first todo',
    description: 'This is my first todo',
    endDate: DateTime.now(),
    category: Category.work,
    priority: Priority.high,
  );
  @override
  Widget build(BuildContext context) {
    return TodoItem(
      item: first_item,
    );
  }
}
