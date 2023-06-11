// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/todo_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  final StreamController<List<ToDoItem>> _todoItemsController =
      StreamController<List<ToDoItem>>.broadcast();

  Stream<List<ToDoItem>> get todoItemsStream => _todoItemsController.stream;

  static Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title TEXT, 
            description TEXT,
            startDate TEXT,
            endDate TEXT,
            isDone BOOLEAN,
            priority TEXT,
            repeat TEXT,
            category TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertTask(ToDoItem task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    _todoItemsController.add(await getToDoItems());
  }

  Future<List<ToDoItem>> getToDoItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (index) {
      return ToDoItem.fromMap(maps[index]);
    });
  }

  // Other CRUD operations (update, delete) can be implemented similarly

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<void> updateItem(ToDoItem updatedItem) async {
    final db = await database;

    await db.update(
      'tasks',
      updatedItem.toMap(),
      where: 'id = ?',
      whereArgs: [updatedItem.id],
    );
  }
}
