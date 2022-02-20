import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';
import 'package:todo_app/cubits/completed_cubit.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/cubits/uncompleted_cubit.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/repository/todo_repo.dart';

GetIt locator = GetIt.instance;

setupProvider() {
  locator.registerLazySingleton(() => GlobalKey<NavigatorState>());
  locator.registerSingleton(TodoRepository());

  locator.registerSingleton(TodosCubit(locator<TodoRepository>()));
  locator.registerSingleton(UncompletedCubit(locator<TodoRepository>()));
  locator.registerSingleton(CompletedCubit(locator<TodoRepository>()));

  locator.registerSingleton(AddTodoCubit(locator<TodoRepository>()));

  locator.registerSingleton(
      EditTodoCubit(locator<TodoRepository>(),));
}
