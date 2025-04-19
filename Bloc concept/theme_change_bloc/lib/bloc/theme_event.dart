// theme_event.dart

import 'package:flutter/material.dart';

abstract class ThemeEvent {}

class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;
  SetThemeMode(this.themeMode);
}
