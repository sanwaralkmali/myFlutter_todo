// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'components/space.dart';

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
              });
            },
            // Add more customization as per your requirement
          ),
          spaceH(16),
          Text(
            _getFormattedSelectedDate(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          spaceH(16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        task.isCompleted = value!;
                      });
                    },
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

class Task {
  final String title;
  final String description;
  bool isCompleted;

  Task(
      {required this.title,
      required this.description,
      required this.isCompleted});
}

List<Task> tasks = [
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  Task(title: 'Task 1', description: 'Description 1', isCompleted: true),
  Task(title: 'Task 2', description: 'Description 2', isCompleted: false),
  // Add more tasks here
];
