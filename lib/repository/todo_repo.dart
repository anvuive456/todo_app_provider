import 'package:intl/intl.dart';
import 'package:todo_app/core/hive_helper.dart';
import 'package:todo_app/model/todo_model.dart';

class TodoRepository {
  Future<List<Todo>> fetchTodos() async {
    return HiveHelper().getTodos();
  }

  Future<List<Todo>> fetchUncompletedTodos() async {
    return await HiveHelper().getUncompletedTodos();
  }

  Future<List<Todo>> fetchCompletedTodos() async {
    return await HiveHelper().getCompletedTodos();
  }


  Future<bool> changeCompletionStatus(Todo todo) async{
   return await HiveHelper().toggleTodo(todo: todo);
  }

  Future<Todo> addTodo(Todo todo) async {
    return await HiveHelper().addTodo(todo);
    // return await FakeData.addTodo(todo).then((value) => value);
  }

  Future<bool> deleteTodo(Todo todo) async {
    return await HiveHelper().deleteTodo(todo);
  }

  Future<Todo?> getDetailTodo(String key) async{
    return await HiveHelper().getTodo(key);

  }

// Future<bool> updateTodo(String text, int id) async {
//   final patchObject = {"title": text};
//   return await _service.patchTodo(patchObject, id);
// }
}

class FakeData {
  static List<Todo> fakeTodos = [
    Todo(
        id: 1,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 2,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 3,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 4,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 5,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 6,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
    Todo(
        id: 7,
        title: 'avc',
        date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
  ];

  static Future<Todo> addTodo(Todo todo) async {
    fakeTodos.add(todo);
    return todo;
  }

  static Future<bool> deleteTodo(int? id) async {
    if(id ==null) return false;
    fakeTodos.removeWhere((element) => element.id == id);
    if (fakeTodos.contains(
        fakeTodos.where((element) => element.id == id).toList().first))
      return false;
    else
      return true;
  }
}
