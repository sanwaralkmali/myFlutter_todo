import 'package:flutter/material.dart';

class ToDoItem {
  String title;
  String description;
  DateTime? startDate;
  DateTime? endDate;
  bool isDone;
  Priority priority;
  Repeat repeat;
  TaskCategory category;

  ToDoItem({
    required this.title,
    required this.description,
    this.startDate,
    this.endDate,
    this.isDone = false,
    required this.priority,
    this.repeat = Repeat.never,
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

  Icon getTaskCategoryIcon(double size) {
    switch (category) {
      case TaskCategory.personal:
        return Icon(
          Icons.person,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.work:
        return Icon(
          Icons.work,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.shopping:
        return Icon(
          Icons.shopping_cart,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.others:
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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'isDone': isDone,
      'priority': priority.name,
      'repeat': repeat.name,
      'Taskcategory': category.name,
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    print(map);

    print('title: ${map['title']}');
    print('description: ${map['description']}');
    // print('startDate: ${}');
    // print('endDate: ${}');
    print('isDone: ${map['isDone']}');
    print('priority: ${map['priority']}');
    print('repeat: ${map['repeat']}');
    print('category: ${map['category']}');

    return ToDoItem(
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate'].toString().substring(0, 16)),
      endDate: DateTime.parse(map['endDate'].toString().substring(0, 16)),
      isDone: map['isDone'] == 1,
      priority: _parsePriority(map['priority'] ?? 'low'),
      repeat: _parseRepeat(map['repeat'] ?? 'never'),
      category: _parseTaskCategory(map['category'] ?? 'others'),
    );
  }

  static Priority _parsePriority(String value) {
    switch (value) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      default:
        return Priority.medium;
    }
  }

  static Repeat _parseRepeat(String value) {
    switch (value) {
      case 'never':
        return Repeat.never;
      case 'daily':
        return Repeat.daily;
      case 'weekly':
        return Repeat.weekly;
      case 'monthly':
        return Repeat.monthly;
      case 'yearly':
        return Repeat.yearly;
      default:
        return Repeat.never;
    }
  }

  static TaskCategory _parseTaskCategory(String value) {
    switch (value) {
      case 'personal':
        return TaskCategory.personal;
      case 'work':
        return TaskCategory.work;
      case 'shopping':
        return TaskCategory.shopping;
      case 'others':
        return TaskCategory.others;
      default:
        return TaskCategory.others;
    }
  }
}

enum Priority { low, medium, high }

enum Repeat { never, daily, weekly, monthly, yearly }

enum TaskCategory { personal, work, shopping, others }
