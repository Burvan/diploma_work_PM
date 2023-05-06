import 'package:diplom_work/ui/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:diplom_work/ui/widgets/expense_widget/expense_data.dart';
import 'package:diplom_work/ui/widgets/habit_widget/habit_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/theme_switcher/theme_switcher_bloc.dart';
import '../expense_widget/expenses_widget.dart';
import '../task_widget/task_widget.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';


import 'my_drawer.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int screenIndex = 0;

  void _onTabChange(int index) {
    if (screenIndex == index) return;
    setState(() {
      screenIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode =
        context.watch<ThemeSwitcherBloc>().state.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            const Expanded(
              child: Center(child: Text('Personal Manager')),
            ),
            Switch(
              onChanged: (bool value) {
                context.read<ThemeSwitcherBloc>().add(
                  themeMode == ThemeMode.light
                      ? SwitchThemeToDark()
                      : SwitchThemeToLight(),
                );
              },
              value: themeMode == ThemeMode.light ? false : true,
            ),
          ],
        ),
        //centerTitle: true,
        //backgroundColor: Colors.transparent,
        //elevation: 0,
        //   leading: Builder(
        //     builder: (context) => IconButton(
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //         icon: const Icon(
        //           Icons.menu,
        //           size: 30,
        //           color: Colors.white,
        //         )),
        //   ),
      ),
      //drawer: const MyDrawer(),
      body: IndexedStack(
        index: screenIndex,
        children: [
          ChangeNotifierProvider(
            create: (context) => ExpenseData(),
            builder: (context, child) => const ExpensesWidget(),
          ),
          const HabitWidget(),
          const TaskWidget(),
        ],
      ),
      bottomNavigationBar: GoogleBottomBar(onTabChange: _onTabChange),
    );
  }
}
