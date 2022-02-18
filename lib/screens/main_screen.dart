import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/all_todo_screen.dart';
import 'package:todo_app/screens/completed_screen.dart';
import 'package:todo_app/screens/uncompleted_screen.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: () {
          TodoDialog.showAddTodo(context: context);
        },
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  _moveToPage(0);
                },
                icon: Icon(Icons.list)),
            IconButton(
                onPressed: () {
                  _moveToPage(1);
                },
                icon: Icon(Icons.note)),
            IconButton(
                onPressed: () {
                  _moveToPage(2);
                },
                icon: Icon(Icons.check)),
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [AllTodoScreen(), UncompletedScreen(), CompletedScreen()]),
    );
  }

  void _moveToPage(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }





}
