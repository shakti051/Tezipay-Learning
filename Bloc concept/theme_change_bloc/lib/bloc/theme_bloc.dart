// theme_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeMode.system)) {
    on<SetThemeMode>(_onSetThemeMode);
    _loadTheme();
  }

  Future<void> _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', event.themeMode.name);
    emit(ThemeState(event.themeMode));
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString('theme') ?? 'system';

    ThemeMode mode;
    switch (storedTheme) {
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }
    add(SetThemeMode(mode));
  }
}
