// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_todos/screens/components/space.dart';
import '../../data/todo_item.dart';
import '../../db/database_helper.dart';

class TaskAlertDialog extends StatefulWidget {
  TaskAlertDialog({Key? key}) : super(key: key);
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  _TaskAlertDialogState createState() => _TaskAlertDialogState();
}

class _TaskAlertDialogState extends State<TaskAlertDialog> {
  String title = '';
  String description = '';
  Repeat repeatValue = Repeat.never;
  TaskCategory taskTypeValue = TaskCategory.others;
  Priority priorityValue = Priority.low;
  DateTime? endingDate;
  DateTime? scheduledDate;
  bool showWarning = false;

  void changeRepeatValue(String value) {
    setState(() {
      switch (value) {
        case 'never':
          repeatValue = Repeat.never;
          break;
        case 'daily':
          repeatValue = Repeat.daily;
          break;
        case 'weekly':
          repeatValue = Repeat.weekly;
          break;
        case 'monthly':
          repeatValue = Repeat.monthly;
          break;
        case 'yearly':
          repeatValue = Repeat.yearly;
          break;
        default:
          repeatValue = Repeat.never;
      }
    });
  }

  void changeTaskTypeValue(String value) {
    setState(() {
      switch (value) {
        case 'others':
          taskTypeValue = TaskCategory.others;
          break;
        case 'work':
          taskTypeValue = TaskCategory.work;
          break;
        case 'personal':
          taskTypeValue = TaskCategory.personal;
          break;
        case 'shopping':
          taskTypeValue = TaskCategory.shopping;
          break;
        default:
          taskTypeValue = TaskCategory.others;
      }
    });
  }

  void changePriorityValue(String value) {
    setState(() {
      switch (value) {
        case 'low':
          priorityValue = Priority.low;
          break;
        case 'medium':
          priorityValue = Priority.medium;
          break;
        case 'high':
          priorityValue = Priority.high;
          break;
        default:
          priorityValue = Priority.low;
      }
    });
  }

  addNewTask() {
    if (title.isNotEmpty) {
      if (description.isEmpty) description = 'No description provided';

      ToDoItem task = ToDoItem(
          id: null,
          title: title,
          description: description,
          startDate: DateTime.now(),
          scheduledDate: scheduledDate ??= DateTime.now(),
          endDate: endingDate,
          isDone: false,
          priority: priorityValue,
          repeat: repeatValue,
          category: taskTypeValue);

      widget.databaseHelper.insertTask(task);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "New Task Added",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 207, 255, 209),
          ),
        ),
      ));
      Navigator.of(context).pop();
    } else {
      setState(() {
        showWarning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                    showWarning = false;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                ),
              ),
              spaceH(6),
              if (showWarning)
                const Text(
                  'Please enter a title',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              spaceH(16),
              Row(
                children: [
                  const Text('Repeat:'),
                  spaceW(8),
                  DropdownButton<String>(
                    onChanged: (value) => changeRepeatValue(value.toString()),
                    value: repeatValue.name,
                    items: [
                      DropdownMenuItem(
                        value: Repeat.never.name,
                        child: const Text('Never'),
                      ),
                      DropdownMenuItem(
                        value: Repeat.daily.name,
                        child: const Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: Repeat.weekly.name,
                        child: const Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: Repeat.monthly.name,
                        child: const Text('Monthly'),
                      ),
                      DropdownMenuItem(
                        value: Repeat.yearly.name,
                        child: const Text('Yearly'),
                      ),
                    ],
                  ),
                ],
              ),
              spaceH(16),
              Row(
                children: [
                  const Text('Task Type:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    onChanged: (value) => changeTaskTypeValue(value.toString()),
                    value: taskTypeValue.name,
                    items: [
                      DropdownMenuItem(
                        value: TaskCategory.others.name,
                        child: const Text('Others'),
                      ),
                      DropdownMenuItem(
                        value: TaskCategory.personal.name,
                        child: const Text('Personal'),
                      ),
                      DropdownMenuItem(
                        value: TaskCategory.shopping.name,
                        child: const Text('Shopping'),
                      ),
                      DropdownMenuItem(
                        value: TaskCategory.work.name,
                        child: const Text('Work'),
                      ),
                    ],
                  ),
                ],
              ),
              spaceH(16),
              Row(
                children: [
                  const Text('Priority:'),
                  spaceW(8),
                  DropdownButton<String>(
                    onChanged: (value) => changePriorityValue(value.toString()),
                    value: priorityValue.name,
                    items: [
                      DropdownMenuItem(
                        value: Priority.low.name,
                        child: const Text('Low'),
                      ),
                      DropdownMenuItem(
                        value: Priority.medium.name,
                        child: const Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: Priority.high.name,
                        child: const Text('High'),
                      ),
                    ],
                  ),
                ],
              ),
              spaceH(16),
              TextField(
                onChanged: (value) => setState(() {
                  description = value;
                }),
                cursorWidth: 21.0,
                decoration: const InputDecoration(
                  labelText: 'Task description',
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                  'Due Date: ${scheduledDate == null ? 'Today' : scheduledDate.toString().substring(0, 16)}'),
              spaceH(16),
              TextButton(
                onPressed: () async {
                  TimeOfDay selectedTime = TimeOfDay.now();

                  final newDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  if (newDate != null) {
                    // ignore: use_build_context_synchronously
                    final newTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );

                    if (newTime != null) {
                      setState(() {
                        scheduledDate = DateTime(
                          newDate.year,
                          newDate.month,
                          newDate.day,
                          newTime.hour,
                          newTime.minute,
                        );
                      });
                    }
                  }
                },
                child: const Text('Reschedule'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Add'),
          onPressed: () => addNewTask(),
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
