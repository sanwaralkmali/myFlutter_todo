// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_todos/data/todo_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../styles/textStyle.dart';
import 'components/space.dart';
import '../db/database_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 28));
  final DateTime _lastDay = DateTime.now().subtract(const Duration(days: 1));
  DateTime _selectedDay = DateTime.now().subtract(const Duration(days: 1));
  List<ToDoItem> myTodos = [];
  late bool isDarkMode = false;
  late Color textColor = Colors.black;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    databaseHelper.getTasksByDate(_selectedDay).then((value) {
      setState(() {
        myTodos = value;
      });
    });
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            // Add more customization as per your requirement
          ),
          spaceH(16),
          Text(
            _getFormattedSelectedDate(),
            style: titleStyle.copyWith(
              color: textColor,
            ),
          ),
          spaceH(24),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: myTodos.length,
              itemBuilder: (context, index) {
                final task = myTodos[index];
                String timeTaken =
                    task.endDate != null ? task.getTimeTaken() : 'NOT DONE';
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      spaceH(8),
                      Text(task.description),
                      spaceH(8),
                      Text(
                        'Taken time $timeTaken',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    task.isDone ? Icons.check_circle : Icons.cancel,
                    color: task.isDone ? Colors.green : Colors.red,
                  ),
                  leadingAndTrailingTextStyle: TextStyle(
                    color: textColor,
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

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      textColor = isDarkMode ? Colors.white : Colors.black;
    });
  }
}
