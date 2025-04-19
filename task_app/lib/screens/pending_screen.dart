import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/my_drawer.dart';
import 'package:task_app/widgets/task_list.dart';
import '../models/task.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});
  static const id = 'tasks_screen';

  //   @override
  //   State<PendingTasksScreen> createState() => _TasksScreenState();
  // }
  // class _TasksScreenState extends State<PendingTasksScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.pendingTask;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Chip(label: Text('${tasksList.length}: Pending: | ${state.completedTask.length} Completed'))),
            TaskList(tasksList: tasksList),
          ],
        );
      },
    );
  }
}
