import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation_bloc.dart';
import 'bloc/navigation_event.dart';
import 'bloc/navigation_state.dart';
import 'pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  Widget _getPage(NavigationState state) {
    if (state is SettingsPageState) return SettingsPage();
    if (state is AboutPageState) return AboutPage();
    return HomePage(); // default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Navigation Drawer BLoC")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(
              title: Text("Home"),
              onTap: () {
                context.read<NavigationBloc>().add(NavigateToHome());
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                context.read<NavigationBloc>().add(NavigateToSettings());
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("About"),
              onTap: () {
                context.read<NavigationBloc>().add(NavigateToAbout());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return _getPage(state);
        },
      ),
    );
  }
}
