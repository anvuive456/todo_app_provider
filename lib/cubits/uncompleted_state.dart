part of 'uncompleted_cubit.dart';

@immutable
abstract class UncompletedState {}

class UncompletedInitial extends UncompletedState {}
class TodosLoaded extends UncompletedState{
  List<Todo> todos=[];

  TodosLoaded(this.todos);
}