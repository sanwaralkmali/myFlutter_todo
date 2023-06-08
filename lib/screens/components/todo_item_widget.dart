import 'package:flutter/material.dart';
import '../../data/todo_item.dart';
import '../../styles/textStyle.dart';
import 'space.dart';

// ignore: must_be_immutable
class TodoItem extends StatefulWidget {
  ToDoItem item;
  TodoItem({super.key, required this.item});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: widget.item.getPriorityColor(),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      widget.item.getCategoryIcon(32),
                      spaceH(3),
                      Text(
                        widget.item.category.name,
                      ),
                    ],
                  ),
                  spaceW(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: itemTitleText,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.item.startDate.toString().substring(0, 10),
                            style: dateTextStyle,
                          ),
                          Text(
                            widget.item.startDate.toString().substring(10, 20),
                            style: dateTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: widget.item.getRepeatIcon(48),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Color.fromARGB(255, 218, 218, 218),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.description,
                    style: descriptionStyle,
                  ),
                  spaceH(10),
                  Text(
                    'Ending date :  ${widget.item.endDate == null ? 'Today' : widget.item.endDate.toString().substring(0, 17)}',
                    style: dateTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                widget.item.endDate = DateTime(
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
                      Checkbox(
                        value: widget.item.isDone,
                        onChanged: (bool? value) {
                          setState(() {
                            widget.item.isDone = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  spaceH(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
