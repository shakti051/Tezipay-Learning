// pages.dart
import 'package:drawer_demo/bloc/navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Home Page"));
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Center(child: Text("Settings Page"));
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(width: double.infinity),
      ElevatedButton(
        onPressed: () {
          context.read<NavigationBloc>().add(NavigateToSettings());
        },
        child: Text("Go to setting"),
      ),
      Center(child: Text("About Page")),
    ],
  );
}
