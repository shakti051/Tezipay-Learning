import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';
import '../../add_task/views/fab.dart';
import 'category_card.dart';
import 'selected_category.dart';
import 'selected_tdos_list.dart';
import 'task_card.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  _HomeView();
  }
}

class _HomeView extends StatelessWidget {
     _HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FAB(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: CategoryCard(text: "3 done", color: Colors.green),
                ),
                Expanded(
                  child: CategoryCard(text: "1 Pending", color: Colors.orange),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('5 To Do', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            SelectedCategory(),
            const SizedBox(height: 20),
            SelectedTodosList(),
          ],
        ),
      ),
    );
  }
}

