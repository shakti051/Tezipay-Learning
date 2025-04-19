
// home_screen.dart
import 'package:flutter/material.dart';
import 'package:theme_change_bloc/theme_dialogue.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: () => showThemeDialog(context),
          ),
        ],
      ),
      body: const Center(
        child: Text("Tap the palette icon to change theme"),
      ),
    );
  }
}
