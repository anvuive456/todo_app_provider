import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';

class DetailTodo extends StatelessWidget {
  final String todoKey;

  const DetailTodo({Key? key, required this.todoKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EditTodoCubit>().getDetailTodo(key: todoKey);
    return BlocBuilder<EditTodoCubit, EditTodoState>(
      builder: (context, state) {
        if (state is DetailState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.todo.title,
              ),
            ),
            body: Container(
              child: Text(state.todo.id.toString()),
            ),
          );
        } else if (state is EditTodoError)
          return Center(
            child: Text(state.error),
          );
        else
          return Center(
            child: Text('error in state'),
          );
      },
    );
  }
}
