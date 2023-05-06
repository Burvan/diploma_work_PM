import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/default_theme.dart';
import '../../themes/theme_switcher/theme_switcher_bloc.dart';
import '../main_screen/main_screen_widget.dart';


class MyDiplomApp extends StatelessWidget {
  const MyDiplomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeSwitcherBloc(ThemeMode.light),
      child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
        builder: (context, state) {
          return MaterialApp(
            theme: DefaultTheme.light,
            darkTheme: DefaultTheme.dark,
            themeMode: state.themeMode,
            // theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,

            home: const MainScreenWidget(),
          );
        }

      ),

    );
  }
}

// MaterialApp(
// theme: DefaultTheme.light,
// darkTheme: DefaultTheme.dark,
// themeMode: ThemeMode.light,
// // theme: ThemeData.dark(),
// debugShowCheckedModeBanner: false,
//
// home: const MainScreenWidget(),
// routes: {
// '/change_theme_screen': (context) => const ThemeScreenWidget(),
// },
// );