// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_todos/styles/textStyle.dart';
import '../db/database_helper.dart';
import './components/todo_item_widget.dart';
import '../data/todo_item.dart';
import 'components/myAlertDialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: non_constant_identifier_names
  List<ToDoItem> myTodos = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    databaseHelper.getTasksByDate(DateTime.now()).then((value) {
      setState(() {
        myTodos = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      databaseHelper.getTasksByDate(DateTime.now()).then((value) {
        setState(() {
          myTodos = value;
        });
      });
    });

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
                      int reverseIndex = myTodos.length - 1 - index;
                      return TodoItem(
                        item: myTodos[reverseIndex],
                      );
                    }),
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
