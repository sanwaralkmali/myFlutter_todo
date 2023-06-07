import 'package:flutter/material.dart';
import '../../data/todo_item.dart';
import '../../styles/textStyle.dart';

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
      margin: const EdgeInsets.all(4.0),
      color: widget.item.getPriorityColor(),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  widget.item.getCategoryIcon(36),
                  const SizedBox(
                    width: 16,
                  ),
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
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            widget.item.startDate.toString().substring(10, 20),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    widget.item.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.item.endDate.toString().substring(0, 10),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Rescdulde'),
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
