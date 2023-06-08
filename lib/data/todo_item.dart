import 'package:flutter/material.dart';

class ToDoItem {
  String title;
  String description;
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  bool isDone;
  Priority priority;
  Repeat repeat = Repeat.never;
  Category category;

  ToDoItem({
    required this.title,
    this.isDone = false,
    required this.description,
    required this.priority,
    required this.category,
  });

  void toggleDone() {
    isDone = !isDone;
  }

  Icon getPriorityIcon() {
    switch (priority) {
      case Priority.low:
        return const Icon(
          Icons.arrow_downward,
          color: Colors.black,
        );
      case Priority.medium:
        return const Icon(
          Icons.arrow_right,
          color: Colors.black,
        );
      case Priority.high:
        return const Icon(
          Icons.arrow_upward,
          color: Colors.black,
        );
      default:
        return const Icon(
          Icons.arrow_right,
          color: Colors.black,
        );
    }
  }

  Icon getCategoryIcon(double size) {
    switch (category) {
      case Category.personal:
        return Icon(
          Icons.person,
          color: Colors.black,
          size: size.toDouble(),
        );
      case Category.work:
        return Icon(
          Icons.work,
          color: Colors.black,
          size: size.toDouble(),
        );
      case Category.shopping:
        return Icon(
          Icons.shopping_cart,
          color: Colors.black,
          size: size.toDouble(),
        );
      case Category.others:
        return Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: size.toDouble(),
        );
      default:
        return Icon(
          Icons.arrow_right,
          color: Colors.black,
          size: size.toDouble(),
        );
    }
  }

  Image getRepeatIcon(double size) {
    switch (repeat) {
      case Repeat.never:
        return Image.asset(
          'assets/icons/repeat/never.png',
          height: size,
        );
      case Repeat.daily:
        return Image.asset(
          'assets/icons/repeat/day.png',
          height: size,
        );

      case Repeat.weekly:
        return Image.asset(
          'assets/icons/repeat/week.png',
          height: size,
        );

      case Repeat.monthly:
        return Image.asset(
          'assets/icons/repeat/month.png',
          height: size,
        );

      case Repeat.yearly:
        return Image.asset(
          'assets/icons/repeat/year.png',
          height: size,
        );

      default:
        return Image.asset(
          'assets/icons/repeat/never.png',
          height: size,
        );
    }
  }

  Color getPriorityColor() {
    switch (priority) {
      case Priority.low:
        return const Color.fromARGB(255, 107, 169, 109);
      case Priority.medium:
        return const Color.fromARGB(46, 192, 232, 91);
      case Priority.high:
        return const Color.fromRGBO(222, 81, 76, 32);
      default:
        return const Color.fromARGB(255, 228, 220, 140);
    }
  }
}

enum Priority { low, medium, high }

enum Repeat { never, daily, weekly, monthly, yearly }

enum Category { personal, work, shopping, others }
