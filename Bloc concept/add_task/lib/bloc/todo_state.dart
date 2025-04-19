part of 'todo_bloc.dart';

class TodoState {
  final List<Todo> todos;
  
  TodoState({this.todos = const []});

  TodoState copyWith({List<Todo>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }
}
