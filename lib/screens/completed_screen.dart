import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/cubits/completed_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  _CompletedScreenState createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  void initState() {
    context.read<CompletedCubit>().fetchTodos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.titleCompletedTodos),
          actions: [
            IconButton(
                onPressed: () {
                  TodoDialog.showAddTodo(context: context);
                },
                icon: Icon(Icons.add))
          ],
        ),
      body: BlocBuilder<CompletedCubit,CompletedState>(
        builder: (context, state) {
          if (state is TodosLoaded && state.todos.isNotEmpty) {
            return TodoList(todos: state.todos, );
          } else {
            return Center(
              child: Text(AppStrings.msgNoCompletedData),
            );
          }
        }
      )
    );
  }
}
