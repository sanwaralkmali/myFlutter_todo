import 'package:flutter/material.dart';

class TaskAlertDialog extends StatefulWidget {
  @override
  _TaskAlertDialogState createState() => _TaskAlertDialogState();
}

class _TaskAlertDialogState extends State<TaskAlertDialog> {
  String title = '';
  String description = '';
  String repeatValue = 'Never';
  String taskTypeValue = 'Work';
  String priorityValue = 'Low';
  String endingDate = 'Today';

  void changeRepeatValue(String value) {
    setState(() {
      repeatValue = value;
    });
  }

  void changeTaskTypeValue(String value) {
    setState(() {
      taskTypeValue = value;
    });
  }

  void changePriorityValue(String value) {
    setState(() {
      priorityValue = value;
    });
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
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Task Title',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Repeat:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    onChanged: (value) => changeRepeatValue(value.toString()),
                    value: repeatValue,
                    items: const [
                      DropdownMenuItem(
                        value: 'Never',
                        child: Text('Never'),
                      ),
                      DropdownMenuItem(
                        value: 'Daily',
                        child: Text('Daily'),
                      ),
                      DropdownMenuItem(
                        value: 'Weekly',
                        child: Text('Weekly'),
                      ),
                      DropdownMenuItem(
                        value: 'Monthly',
                        child: Text('Monthly'),
                      ),
                      DropdownMenuItem(
                        value: 'Yearly',
                        child: Text('Yearly'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Task Type:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    onChanged: (value) => changeTaskTypeValue(value.toString()),
                    value: taskTypeValue,
                    items: const [
                      DropdownMenuItem(
                        value: 'Work',
                        child: Text('Work'),
                      ),
                      DropdownMenuItem(
                        value: 'Personal',
                        child: Text('Personal'),
                      ),
                      DropdownMenuItem(
                        value: 'Shopping',
                        child: Text('Shopping'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Priority:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    onChanged: (value) => changePriorityValue(value.toString()),
                    value: priorityValue,
                    items: const [
                      DropdownMenuItem(
                        value: 'Low',
                        child: Text('Low'),
                      ),
                      DropdownMenuItem(
                        value: 'Medium',
                        child: Text('Medium'),
                      ),
                      DropdownMenuItem(
                        value: 'High',
                        child: Text('High'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const TextField(
                cursorWidth: 21.0,
                decoration: InputDecoration(
                  labelText: 'Task description',
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Due Date: $endingDate'),
              const SizedBox(height: 16.0),
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
                        endingDate = DateTime(
                          newDate.year,
                          newDate.month,
                          newDate.day,
                          newTime.hour,
                          newTime.minute,
                        ).toString().substring(0, 16);
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
          onPressed: () {
            // Perform reschedule action
          },
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
