import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repo.dart';

part 'completed_state.dart';

class CompletedCubit extends Cubit<CompletedState> {
  TodoRepository _repository;
  CompletedCubit(this._repository) : super(CompletedInitial());

  Future<void> fetchTodos() async {
    _repository.fetchCompletedTodos().then((value) => emit(TodosLoaded(value)));
  }
}
