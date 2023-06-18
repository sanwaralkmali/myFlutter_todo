import 'package:flutter/material.dart';
import 'package:my_todos/screens/components/editAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/todo_item.dart';
import '../../styles/textStyle.dart';
import 'space.dart';
import '../../db/database_helper.dart';

// ignore: must_be_immutable
class TodoItem extends StatefulWidget {
  ToDoItem item;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  TodoItem({super.key, required this.item});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late bool isDarkMode = false;
  late Color textColor = Colors.black;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: widget.item.getPriorityColor(isDarkMode),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      widget.item.getTaskCategoryIcon(32),
                      spaceH(3),
                      Text(
                        widget.item.category.name,
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  spaceW(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          widget.item.title,
                          style: itemTitleText.copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.item.startDate.toString().substring(0, 10),
                            style: dateTextStyle.copyWith(
                              color: textColor,
                            ),
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
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EditAlertDialog(item: widget.item);
                              },
                            );
                          },
                          child: const Icon(Icons.edit,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
                color: isDarkMode
                    ? const Color.fromARGB(255, 188, 188, 188)
                    : Colors.grey[300],
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
                    widget.item.isDone
                        ? 'Taken time : ${widget.item.getTimeTaken()}'
                        : 'Due to :  ${widget.item.scheduledDate.toString().substring(0, 10) == DateTime.now().toString().substring(0, 10) ? 'Today' : widget.item.scheduledDate.toString().substring(0, 17)}',
                    style: dateTextStyle.copyWith(
                      color: const Color.fromARGB(207, 31, 29, 29),
                    ),
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
                                widget.item.scheduledDate = DateTime(
                                  newDate.year,
                                  newDate.month,
                                  newDate.day,
                                  newTime.hour,
                                  newTime.minute,
                                );
                                widget.databaseHelper.updateItem(widget.item);
                              });
                            }
                          }
                        },
                        child: Text(
                          'Reschedule',
                          style: TextStyle(
                            color: isDarkMode
                                ? const Color.fromARGB(247, 36, 90, 68)
                                : const Color.fromARGB(255, 36, 87, 129),
                          ),
                        ),
                      ),
                      Checkbox(
                        value: widget.item.isDone,
                        checkColor: isDarkMode ? Colors.white : Colors.black,
                        fillColor: MaterialStateProperty.all<Color>(
                          isDarkMode
                              ? const Color.fromARGB(255, 36, 87, 129)
                              : const Color.fromARGB(239, 74, 144, 202),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            widget.item.isDone = value!;
                            if (widget.item.isDone) {
                              widget.item.endDate = DateTime.now();
                            } else {
                              widget.item.endDate = null;
                            }
                            widget.databaseHelper.updateItem(widget.item);
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

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      textColor =
          isDarkMode ? const Color.fromARGB(255, 20, 19, 19) : Colors.black;
    });
  }
}
