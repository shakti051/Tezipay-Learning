import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/widgets/task_list.dart';
import '../blocs/tasks_bloc/tasks_bloc.dart';
import '../models/task.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTask;
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
