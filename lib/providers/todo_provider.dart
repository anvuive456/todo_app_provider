import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoProvider  {
   BehaviorSubject<List<Todo>> _todoSubject =BehaviorSubject.seeded([]);
   BehaviorSubject<Todo?> _detailTodoSubject=BehaviorSubject.seeded(null);

  List<Todo> _todos=[];


  Stream<List<Todo>> get todos => _todoSubject.stream;

  Stream<List<Todo>> get completedTodos async*{
    yield _todos.where((element) => element.isCompleted == true).toList();
  }

  Stream<List<Todo>> get unCompletedTodos async*{
   yield  _todos.where((element) => element.isCompleted == false).toList();
  }

  void addTodo({required String title, DateTime? dateTime}) {
    String date = DateFormat('dd-MM-yyyy').format(dateTime ?? DateTime.now());
    Todo todo = Todo(title: title, date: date);
    _todos.add(todo);
    _todoSubject.sink.add(_todos);
  }

  void editTodo({String? title, DateTime? dateTime, required int index}) {
    String? date;
    if (dateTime != null) date = DateFormat('dd-MM-yyyy').format(dateTime);
    _todos[index] = _todos[index].copyWith(title, date);
  }

  void toggleItem(Todo item) {
    item.toggle();
  }

  void removeTodo({required Todo todo}) {
    _todos.remove(todo);
    _todoSubject.sink.add(_todos);
  }

  void getDetailTodo(){

  }
}
