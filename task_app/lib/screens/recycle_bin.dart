import 'package:flutter/material.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/my_drawer.dart';
import 'package:task_app/widgets/task_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin_screen';
  
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Chip(label: Text('Tasks:${state.removedTask.length}'))),
              TaskList(tasksList: state.removedTask),
            ],
          ),
        );
      },
    );
  }
}
