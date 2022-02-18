import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class AllTodoScreen extends StatefulWidget {
  const AllTodoScreen({Key? key}) : super(key: key);

  @override
  _AllTodoScreenState createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.titleAllTodos),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.todos.isEmpty)
            return Center(
              child: Text(AppStrings.msgNoData),
            );
          else
            return ListView.builder(
              shrinkWrap: false,
              itemCount: snapshot.todos.length,
              itemBuilder: (BuildContext ctx, int index) {
                return TodoTile(
                  todo: snapshot.todos[index],
                  index: index,
                );
              },
            );
        },
      ),
    );
  }
}
