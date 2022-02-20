import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/repository/todo_repo.dart';

part 'uncompleted_state.dart';

class UncompletedCubit extends Cubit<UncompletedState> {
  TodoRepository _repository;
  UncompletedCubit(this._repository) : super(UncompletedInitial());

  Future<void> fetchTodos()async {
    _repository.fetchUncompletedTodos().then((value) => emit(TodosLoaded(value)));
  }


}
