part of 'completed_cubit.dart';

@immutable
abstract class CompletedState {}

class CompletedInitial extends CompletedState {}

class TodosLoaded extends CompletedState{
  List<Todo> todos=[];

  TodosLoaded(this.todos);
}