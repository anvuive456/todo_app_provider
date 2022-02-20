import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repo.dart';
import 'package:todo_app/widgets/todo_list.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodoRepository _repository;

  TodosCubit(this._repository) : super(TodosInitial());

  Future<void> fetchTodos()async {
    _repository.fetchTodos().then((value) => emit(TodosLoaded(value)));
  }


  void changeCompletionStatus(int index) {
    final currentState = state;
    if(currentState is TodosLoaded) {
      currentState.todos[index].isCompleted = !currentState.todos[index].isCompleted;
    }
    updateTodoList();
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) emit(TodosLoaded(currentState.todos));
  }

  Future<void> addTodo(Todo todo) async {
    final currentState = state;
    if (currentState is TodosLoaded) {
      currentState.todos.add(todo);
      emit(TodosLoaded(currentState.todos));
    }
    fetchTodos();
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      currentState.todos.remove(todo);
      emit(TodosLoaded(currentState.todos));
    }
  }

  void toggleTodo({required int index}) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      currentState.todos[index].isCompleted = !currentState.todos[index].isCompleted;
      emit(TodosLoaded(currentState.todos));
    }
  }
}
