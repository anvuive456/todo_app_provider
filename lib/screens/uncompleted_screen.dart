import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/cubits/uncompleted_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class UncompletedScreen extends StatefulWidget {
  const UncompletedScreen({Key? key}) : super(key: key);

  @override
  _UncompletedScreenState createState() => _UncompletedScreenState();
}

class _UncompletedScreenState extends State<UncompletedScreen> {

  @override
  void initState() {
     context.read<UncompletedCubit>().fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.titleUncompletedTodos),
          actions: [
            IconButton(
                onPressed: () {
                  TodoDialog.showAddTodo(context: context);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<UncompletedCubit, UncompletedState>(
          builder: (context, state) {
            if (state is TodosLoaded && state.todos.isNotEmpty) {
              return TodoList(todos: state.todos,);
            } else {
              return Center(
                child: Text(AppStrings.msgNoUncompletedData),
              );
            }
          },
        ));
  }
}
