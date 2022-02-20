import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({Key? key, required this.todos, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: todos.length,
      itemBuilder: (BuildContext ctx, int index) {
        return TodoTile(
          todo: todos[index],
          index: index,

        );
      },
    );
  }
}
