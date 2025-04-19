
import 'package:add_task/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter a task'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            final title = _controller.text.trim();
            if (title.isNotEmpty) {
              context.read<TodoBloc>().add(AddTask(title));
              _controller.clear();
            }
          },
        ),
      ],
    );
  }
}
