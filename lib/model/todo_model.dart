import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? date;

  @HiveField(3)
  bool isCompleted;

  Todo({
    this.id,
    this.date,
    required this.title,
    this.isCompleted = false,
  });

  void toggle() {
    this.isCompleted = !isCompleted;
  }

  Todo copyWith(String? title, String? date) =>
      Todo(title: title ?? this.title, date: date ?? this.date);
}
