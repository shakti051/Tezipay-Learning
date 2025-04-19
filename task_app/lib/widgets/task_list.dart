// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/widgets/task_tile.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasksList});
  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children:
              tasksList
                  .map(
                    (task) => ExpansionPanelRadio(
                      value: task.id,
                      headerBuilder: (context, isOpen) => TaskTile(task: task),
                      body: ListTile(
                        title: SelectableText.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Text\n',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: task.title),
                              const TextSpan(
                                text: '\n\nDescription\n',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: task.description),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}

// Expanded(
//       child: ListView.builder(
//         itemCount: tasksList.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           var task = tasksList[index];
//           return TaskTile(task: task);
//         },
//       ),
//     );
