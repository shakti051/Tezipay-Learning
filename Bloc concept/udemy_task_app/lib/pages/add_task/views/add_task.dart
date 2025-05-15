import 'package:flutter/material.dart';
import 'status_card.dart';
import 'submit_btn.dart';
import 'text_input.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddTaskView();
  }
}

class _AddTaskView extends StatelessWidget {
  const _AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            TextInput(),
            const SizedBox(height: 40),
            Row(
              children: [
                StatusCard(text: "todo", color: Colors.red),
                StatusCard(text: "Pending", color: Colors.orange),
                StatusCard(text: "Done", color: Colors.green),
              ],
            ),
            const SizedBox(height: 40),
            SubmitBtn(),
          ],
        ),
      ),
    );
  }
}

