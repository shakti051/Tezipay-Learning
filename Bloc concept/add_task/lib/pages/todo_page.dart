import 'package:add_task/bloc/todo_bloc.dart';
import 'package:add_task/pages/task_list_widget.dart';
import 'package:add_task/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming you've already defined Todo, TodoEvent, AddTask, TodoState, and TodoBloc

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(), // Create the BLoC
      child: Scaffold(
        appBar: AppBar(title: Text('Todo App')),
        body: Column(
          children: [
            AddTaskWidget(), // <- Placed above ListView
            Expanded(child: TaskListWidget()),
          ],
        ),
      ),
    );
  }
}
