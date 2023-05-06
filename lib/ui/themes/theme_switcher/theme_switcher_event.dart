part of 'theme_switcher_bloc.dart';

@immutable
abstract class ThemeSwitcherEvent {}


class SwitchThemeToLight extends ThemeSwitcherEvent {}

class SwitchThemeToDark extends ThemeSwitcherEvent {}