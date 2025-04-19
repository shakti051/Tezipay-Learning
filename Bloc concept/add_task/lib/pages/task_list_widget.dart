import 'package:add_task/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return Center(child: Text('No tasks yet.'));
        }

        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return ListTile(
              title: Text(todo.title),
              trailing: Icon(
                todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
              ),
              onTap: () {
                // Optional: toggle task completion
              },
            );
          },
        );
      },
    );
  }
}
