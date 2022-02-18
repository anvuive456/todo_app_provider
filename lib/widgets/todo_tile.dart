import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final int index;

  const TodoTile({
    Key? key,
    required this.todo,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Provider.of<TodoProvider>(context,listen: false).toggleItem(todo);
        TodoDialog.showEditTodo(index: index, context: context);
      },
      onLongPress: () {
        Provider.of<TodoProvider>(context, listen: false)
            .removeTodo(todo: todo);
      },
      title: Text(
        todo.title,
        style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      subtitle: Text(
        todo.date ?? '',
        style: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing: Checkbox(
        onChanged: (value) {
          Provider.of<TodoProvider>(context, listen: false).toggleItem(todo);
        },
        value: todo.isCompleted,
      ),
    );
  }
}
