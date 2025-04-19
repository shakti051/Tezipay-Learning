import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/todo.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<AddTask>((event, emit) {
      final newTodo = Todo(
        id: DateTime.now().toIso8601String(),
        title: event.title,
      );
      final updatedList = List<Todo>.from(state.todos)..add(newTodo);
      emit(state.copyWith(todos: updatedList));
    });
  }
}
