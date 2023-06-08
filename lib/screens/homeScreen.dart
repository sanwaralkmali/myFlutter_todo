// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_todos/styles/textStyle.dart';
import './components/todo_item_widget.dart';
import '../data/todo_item.dart';
import 'components/myAlertDialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  ToDoItem first_item = ToDoItem(
    title: 'First 545',
    description: 'This is my first todo',
    category: Category.shopping,
    priority: Priority.low,
  );

  // ignore: non_constant_identifier_names
  ToDoItem second_item = ToDoItem(
    title: 'Second todo',
    description: 'This is my Second todo',
    category: Category.work,
    priority: Priority.medium,
  );
  List<ToDoItem> myTodos = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Text(
                  'Today\'s Todos',
                  style: titleStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 180.0,
                  height: 2.0,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: myTodos.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      item: myTodos[index],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TaskAlertDialog();
                  },
                );
              },
              child: Image.asset(
                'assets/icons/add.png',
                width: 42.0,
                height: 42.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
