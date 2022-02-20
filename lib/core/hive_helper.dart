import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:todo_app/model/todo_model.dart';

class HiveHelper {
  static HiveHelper _instance = HiveHelper.internal();

  HiveHelper.internal();

  factory HiveHelper() => _instance;

  late Box<Todo> _box;

  Future<void> init() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(TodoAdapter());
    _box = await Hive.openBox<Todo>('todobox');
  }

  Future<List<Todo>> getTodos() async {
    return _box.values.toList();
  }

  Future<bool> toggleTodo({required Todo todo})async{
    if(_box.get(todo.title) == null) return false;
    else {
      _box.get(todo.title)!.isCompleted = !_box.get(todo.title)!.isCompleted;
      return true;
    }
  }

  void dispose() {
    Hive.close();
  }

  Future<Todo> addTodo(Todo todo) async {
    _box.put(todo.title, todo);
    return todo;
  }

  Future<List<Todo>> getUncompletedTodos() async {
    return _box.values
        .toList()
        .where((element) => element.isCompleted == false)
        .toList();
  }
  Future<List<Todo>> getCompletedTodos() async {
    return _box.values
        .toList()
        .where((element) => element.isCompleted == true)
        .toList();
  }

  Future<bool> deleteTodo(Todo todo) async{
     if(_box.get(todo.title) ==null){
       return false;
     }
     else {
       _box.delete(todo.title);
       return true;
     }
  }

  Future<Todo?> getTodo(String key) async{
    return _box.get(key);
  }
}
