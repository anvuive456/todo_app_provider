import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  List<Todo> get completedTodos {
    return _todos.where((element) => element.isCompleted == true).toList();
  }

  List<Todo> get unCompletedTodos {
    return _todos.where((element) => element.isCompleted == false).toList();
  }

  void addTodo({required String title, DateTime? dateTime}) {
    String date = DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime.now());
    Todo todo = Todo(title: title, date: date);
    _todos.add(todo);
    notifyListeners();
  }

  void editTodo({String? title, DateTime? dateTime, required int index}) {
    String? date;
    if (dateTime != null) date = DateFormat('dd-MM-yyyy').format(dateTime);
    _todos[index] = todos[index].copyWith(title, date);
    notifyListeners();
  }

  void toggleItem(Todo item) {
    item.toggle();
    notifyListeners();
  }

  void removeTodo({required Todo todo}) {
    _todos.remove(todo);
    notifyListeners();
  }
}
