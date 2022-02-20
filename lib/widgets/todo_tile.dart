import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/detail_todo_screen.dart';
import 'package:todo_app/utils/datetime_utils.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';
import 'package:todo_app/widgets/todo_list.dart';

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
      tileColor: _tileColor(),
      onTap: () {
        pushNewScreen(context,
            screen: DetailTodo(todoKey: todo.title),
            customPageRoute: MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                BlocProvider.value(value: locator<EditTodoCubit>())
              ], child: DetailTodo(todoKey: todo.title)),
            ));
        // TodoDialog.showEditTodo(index: index, context: context);
      },
      onLongPress: () {
        TodoDialog.showDeleteTodo(todo: todo, ctx: context, );
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
          BlocProvider.of<EditTodoCubit>(context).changeStatusTodo(todo: todo);
        },
        value: todo.isCompleted,
      ),
    );
  }

  Color _tileColor() {
    DateTime _date = DateFormat('dd-MM-yyyy').parse(todo.date!);
    return DateTimeUtils.isNearEnd(inputDateTime: _date)
        ? Colors.red
        : Colors.grey;
  }
}
