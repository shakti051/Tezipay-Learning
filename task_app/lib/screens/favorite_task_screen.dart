import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/widgets/task_list.dart';

class FavoriteTaskScreen extends StatelessWidget {
  const FavoriteTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.favoriteTask;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Chip(label: Text('${tasksList.length}: Tasks:'))),
            TaskList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
