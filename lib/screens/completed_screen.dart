import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  _CompletedScreenState createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppStrings.titleCompletedTodos
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.completedTodos.isEmpty)
            return Center(
              child: Text(AppStrings.msgNoCompletedData),
            );
          else
          return ListView.builder(
            shrinkWrap: false,
            itemCount: snapshot.completedTodos.length,
            itemBuilder: (BuildContext ctx, int index) {
              return TodoTile(
                todo: snapshot.completedTodos[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
