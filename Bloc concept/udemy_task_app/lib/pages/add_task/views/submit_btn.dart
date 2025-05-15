import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Add new todo',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

