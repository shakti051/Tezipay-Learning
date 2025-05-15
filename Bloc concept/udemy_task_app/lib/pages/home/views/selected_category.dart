import 'package:flutter/material.dart';


class SelectedCategory extends StatelessWidget {
  const SelectedCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
      child: Text(
        'All Tasks',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
