// theme_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_change_bloc/bloc/theme_bloc.dart';
import 'package:theme_change_bloc/bloc/theme_event.dart';


void showThemeDialog(BuildContext context) {
  final currentMode = context.read<ThemeBloc>().state.themeMode;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Choose Theme"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            return RadioListTile<ThemeMode>(
              title: Text(mode.name[0].toUpperCase() + mode.name.substring(1)),
              value: mode,
              groupValue: currentMode,
              onChanged: (selected) {
                context.read<ThemeBloc>().add(SetThemeMode(selected!));
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          )
        ],
      );
    },
  );
}
