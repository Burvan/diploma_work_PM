//import 'package:flutter/material.dart';
part of 'theme_switcher_bloc.dart';

@immutable
abstract class ThemeSwitcherState {
  abstract final ThemeMode themeMode;
}

class InitialThemeMode extends ThemeSwitcherState {
  @override
  final ThemeMode themeMode;

  InitialThemeMode(this.themeMode);
}

class ThemeIsLight extends ThemeSwitcherState {
  @override
  final ThemeMode themeMode = ThemeMode.light;
}

class ThemeIsDark extends ThemeSwitcherState {
  @override
  final ThemeMode themeMode = ThemeMode.dark;
}