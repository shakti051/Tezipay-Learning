part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  TasksState({this.allTask = const []});
  List<Task> allTask;
  @override
  List<Object> get props => [allTask];
}
