import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_switcher_event.dart';
part 'theme_switcher_state.dart';

class ThemeSwitcherBloc extends Bloc<ThemeSwitcherEvent, ThemeSwitcherState> {
  ThemeSwitcherBloc(ThemeMode themeMode) : super(InitialThemeMode(themeMode)) {
    on<SwitchThemeToLight>((event, emit) {
      emit(
        ThemeIsLight(),
      );
    });

    on<SwitchThemeToDark>((event, emit) {
      emit(
        ThemeIsDark(),
      );
    });
  }
}
