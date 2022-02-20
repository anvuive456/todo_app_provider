import 'package:flutter/material.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/core/hive_helper.dart';
import 'package:todo_app/screens/main_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper().init();
  setupProvider();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainScreen(),
    );
  }
}
