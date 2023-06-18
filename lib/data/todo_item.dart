import 'package:flutter/material.dart';

class ToDoItem {
  int? id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? scheduledDate;
  DateTime? endDate;
  bool isDone;
  Priority priority;
  Repeat repeat;
  TaskCategory category;

  ToDoItem({
    required this.id,
    required this.title,
    required this.description,
    this.startDate,
    this.endDate,
    this.scheduledDate,
    this.isDone = false,
    required this.priority,
    this.repeat = Repeat.never,
    required this.category,
  });

  void toggleDone() {
    isDone = !isDone;
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
          Icons.help_outline,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.home:
        return Icon(
          Icons.home,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.education:
        return Icon(
          Icons.school,
          color: Colors.black,
          size: size.toDouble(),
        );
      case TaskCategory.health:
        return Icon(
          Icons.favorite,
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

  Color getPriorityColor(bool isDarkMode) {
    switch (priority) {
      case Priority.low:
        return isDarkMode
            ? const Color.fromARGB(184, 53, 126, 102)
            : const Color.fromARGB(212, 41, 129, 100);
      case Priority.medium:
        return isDarkMode
            ? const Color.fromARGB(230, 65, 146, 184)
            : const Color.fromARGB(215, 53, 112, 160);
      case Priority.high:
        return isDarkMode
            ? const Color.fromARGB(255, 200, 98, 94)
            : const Color.fromARGB(255, 204, 97, 89);
      default:
        return const Color.fromARGB(255, 228, 220, 140);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toString(),
      'scheduledDate': scheduledDate.toString(),
      // ignore: prefer_null_aware_operators
      'endDate': endDate != null ? endDate.toString() : null,
      'isDone': isDone ? 1 : 0,
      'priority': priority.name,
      'repeat': repeat.name,
      'category': category.name,
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      scheduledDate: DateTime.parse(map['scheduledDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      isDone: map['isDone'] == 1,
      priority: _parsePriority(map['priority']),
      repeat: _parseRepeat(map['repeat']),
      category: _parseTaskCategory(map['category']),
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
      case 'home':
        return TaskCategory.home;
      case 'education':
        return TaskCategory.education;
      case 'finance':
        return TaskCategory.finance;
      case 'health':
        return TaskCategory.health;

      default:
        return TaskCategory.others;
    }
  }

  updateValues(title, description, startDate, scheduledDate, isDone, priority,
      repeat, category) {
    this.title = title;
    this.description = description;
    this.startDate = startDate;
    this.scheduledDate = scheduledDate;
    endDate = endDate;
    this.isDone = isDone;
    this.priority = priority;
    this.repeat = repeat;
    this.category = category;
  }

  String getTimeTaken() {
    Duration difference = endDate!.difference(startDate!);
    int days = difference.inDays;
    int hours = difference.inHours - days * 24;
    int minutes = difference.inMinutes - hours * 60 - days * 24 * 60;
    int seconds = difference.inSeconds -
        minutes * 60 -
        hours * 60 * 60 -
        days * 24 * 60 * 60;

    String time = '';
    if (days > 0) time += '$days days ';
    if (hours > 0) time += '$hours hours ';
    if (minutes > 0) time += '$minutes minutes ';
    if (seconds > 0) time += '$seconds seconds ';
    return time;
  }
}

enum Priority { low, medium, high }

enum Repeat { never, daily, weekly, monthly, yearly }

enum TaskCategory {
  personal,
  work,
  home,
  education,
  finance,
  health,
  shopping,
  others
}
