import 'package:flutter/material.dart';

class ToDoItem {
  String title;
  String description;
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  bool isDone;
  Priority priority;
  Repeat repeat;
  Category category;

  ToDoItem({
    required this.title,
    this.isDone = false,
    required this.description,
    required this.priority,
    required this.category,
    this.repeat = Repeat.never,
    this.endDate,
  });

  void toggleDone() {
    isDone = !isDone;
  }

  Icon getPriorityIcon() {
    switch (priority) {
      case Priority.low:
        return const Icon(
          Icons.arrow_downward,
          color: Colors.green,
        );
      case Priority.medium:
        return const Icon(
          Icons.arrow_right,
          color: Colors.yellow,
        );
      case Priority.high:
        return const Icon(
          Icons.arrow_upward,
          color: Colors.red,
        );
      default:
        return const Icon(
          Icons.arrow_right,
          color: Colors.yellow,
        );
    }
  }

  Icon getCategoryIcon(double size) {
    switch (category) {
      case Category.personal:
        return Icon(
          Icons.person,
          color: Colors.green,
          size: size.toDouble(),
        );
      case Category.work:
        return Icon(
          Icons.work,
          color: Colors.yellow,
          size: size.toDouble(),
        );
      case Category.shopping:
        return Icon(
          Icons.shopping_cart,
          color: Colors.red,
          size: size.toDouble(),
        );
      case Category.others:
        return Icon(
          Icons.arrow_right,
          color: Colors.yellow,
          size: size.toDouble(),
        );
      default:
        return Icon(
          Icons.arrow_right,
          color: Colors.yellow,
          size: size.toDouble(),
        );
    }
  }

  Color getPriorityColor() {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return const Color.fromARGB(255, 59, 177, 255);
      case Priority.high:
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }
}

enum Priority { low, medium, high }

enum Repeat { never, daily, weekly, monthly, yearly }

enum Category { personal, work, shopping, others }
