import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/detail_todo_screen.dart';
import 'package:todo_app/screens/main_screen.dart';
import 'package:todo_app/screens/undefined_screen.dart';



class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("ROUTER ${settings.name}");
    switch (settings.name) {
      case RoutesPath.root: return MaterialPageRoute(builder: (context) => MainScreen(),);
      case RoutesPath.root: return MaterialPageRoute(builder: (context) => DetailTodo(todoKey: settings.arguments as String),);

      default:
        return MaterialPageRoute(
            builder: (context) => UndefinedScreen(
            ));
    }
  }

  static MaterialPageRoute _getPageRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}

class RoutesPath {
 static const String root ='/';
 static const String detail ='/detail';
}
