import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/cubits/completed_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/cubits/uncompleted_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repo.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final TodoRepository _repository;

  AddTodoCubit(this._repository) : super(AddTodoInitial());

  void addTodo(String text, DateTime date) {
    if (text.isEmpty) {
      emit(AddTodoError('Todo is empty'));
    } else {
      emit(AddingTodo());
      _repository
          .addTodo(
              Todo(title: text, date: DateFormat('dd-MM-yyyy').format(date)))
          .then((value) {
        locator<TodosCubit>().fetchTodos().whenComplete(() =>
            locator<UncompletedCubit>()
                .fetchTodos()
                .whenComplete(() => emit(TodoAdded())));
      });
    }
  }
}
