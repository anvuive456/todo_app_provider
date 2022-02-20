import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  _AllTodoScreenState createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {

  @override
  void initState() {
    BlocProvider.of<TodosCubit>(context).fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.titleAllTodos),
          actions: [
            BlocProvider.value(
              value: locator<AddTodoCubit>(),
              child: IconButton(
                  onPressed: () {
                    TodoDialog.showAddTodo(context: context);
                  },
                  icon: Icon(Icons.add)),
            )
          ],
        ),
        body: BlocBuilder<TodosCubit, TodosState>(
          builder: (context, state) {
            if (state is TodosLoaded && state.todos.isNotEmpty) {
              return RefreshIndicator(onRefresh: () async {
                await context.read<TodosCubit>().fetchTodos();
              },
              child: TodoList(todos: state.todos, ));
            } else {
              return Center(
                child: Text(AppStrings.msgNoData),
              );
            }
          },
        ));
  }
}
