import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/widgets/todo_tile.dart';

class UncompletedScreen extends StatefulWidget {
  const UncompletedScreen({Key? key}) : super(key: key);

  @override
  _UncompletedScreenState createState() => _UncompletedScreenState();
}

class _UncompletedScreenState extends State<UncompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppStrings.titleUncompletedTodos
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, snapshot, child) {
          if (snapshot.unCompletedTodos.isEmpty)
            return Center(
              child: Text(AppStrings.msgNoUncompletedData),
            );
          else
          return ListView.builder(
            shrinkWrap: false,
            itemCount: snapshot.unCompletedTodos.length,
            itemBuilder: (BuildContext ctx, int index) {
              return TodoTile(
                todo: snapshot.unCompletedTodos[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
