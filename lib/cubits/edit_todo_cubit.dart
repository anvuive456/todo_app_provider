import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/cubits/completed_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/cubits/uncompleted_cubit.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repo.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final TodoRepository _repository;

  EditTodoCubit(
    this._repository,
  ) : super(EditTodoInitial());

  deleteTodo({required Todo todo}) {
    _repository.deleteTodo(todo).then((isDeleted) {
      if (isDeleted) {
        locator<TodosCubit>().deleteTodo(todo);
        locator<UncompletedCubit>().fetchTodos();
        locator<CompletedCubit>().fetchTodos();
        emit(TodoDeleted());
      }
    });
  }

  getDetailTodo({required String key}) {
    _repository.getDetailTodo(key).then((value) {
      if (value == null)
        emit(EditTodoError('Todo not found'));
      else
        emit(DetailState(value));
    });
  }

  // void updateTodo(Todo todo, String text) {
  //   if (text.isEmpty) {
  //     emit(EditTodoError('Todo is empty'));
  //     return;
  //   }
  //   emit(EditingTodo());
  //   _repository.(text, todo.id).then((isEdited) {
  //     if (isEdited) {
  //       todo.title = text;
  //       _todosCubit.updateTodoList();
  //       emit(TodoEdited());
  //     }
  //   });
  // }
  changeStatusTodo({required Todo todo}) {
    _repository.changeCompletionStatus(todo).then((isChanged) {
      if (isChanged == true) {
        locator<TodosCubit>().fetchTodos();
        locator<UncompletedCubit>().fetchTodos();
        locator<CompletedCubit>().fetchTodos();
        emit(TodoChanged());
      } else {
        emit(EditTodoError('error while changeStatus'));
        print('${state}');
      }
    });
  }
}
