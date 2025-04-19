part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddTask extends TodoEvent {
  final String title;

  AddTask(this.title);
}
