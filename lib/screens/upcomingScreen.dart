// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:my_todos/data/todo_item.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'components/editAlertDialog.dart';
import 'components/space.dart';
import '../db/database_helper.dart';
import '../styles/textStyle.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateTime _firstDay = DateTime.now().add(const Duration(days: 1));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 7));
  DateTime _selectedDay = DateTime.now().add(const Duration(days: 1));
  List<ToDoItem> myTodos = [];
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    databaseHelper.getTasksByDate(_selectedDay).then((value) {
      setState(() {
        myTodos = value;
      });
    });
    super.initState();
  }

  refreshScreen() {
    setState(() {
      databaseHelper.getTasksByDate(_selectedDay).then((value) {
        setState(() {
          myTodos = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshScreen();
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: _firstDay,
            lastDay: _lastDay,
            calendarFormat: _calendarFormat,
            focusedDay: _selectedDay,
            onDaySelected: (day, _) {
              setState(() {
                _selectedDay = day;
                databaseHelper.getTasksByDate(_selectedDay).then((value) {
                  myTodos = value;
                });
              });
            },
          ),
          spaceH(16),
          Text(
            _getFormattedSelectedDate(),
            style: titleStyle,
          ),
          spaceH(16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: myTodos.length,
              itemBuilder: (context, index) {
                final task = myTodos[index];
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: task.getPriorityColor(),
                      width: 2.5,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: itemTitleText,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.description,
                          style: descriptionStyle,
                        ),
                        spaceH(2.5),
                        Text(
                          'Priority : ${myTodos[index].priority.name.toUpperCase()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        spaceH(2.5),
                        Text(
                          'Task type : ${myTodos[index].category.name.toUpperCase()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                      onSelected: (String value) {
                        if (value == 'edit') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditAlertDialog(item: myTodos[index]);
                            },
                          );
                        } else if (value == 'delete') {
                          databaseHelper.deleteItem(myTodos[index].id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Task Deleted Successfully",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 119, 34, 34),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedSelectedDate() {
    final selectedDate = _selectedDay;
    final formattedDate = DateFormat('EEEE d MMMM yyyy').format(selectedDate);
    return formattedDate.toUpperCase();
  }
}
