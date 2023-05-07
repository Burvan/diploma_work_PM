import 'package:diplom_work/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GoogleBottomBar extends StatelessWidget {
  void Function(int)? onTabChange;
  GoogleBottomBar({Key? key, required this.onTabChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        tabBackgroundColor: Colors.indigo.shade200,
        tabActiveBorder: Border.all(color: Colors.black12),
        color: Colors.indigo[300],
        activeColor: Colors.indigo[500],
        //backgroundColor: firstPrimaryColor,

        tabs: const [
          GButton(
            icon: Icons.currency_ruble,
            text: 'Expenses',
          ),
          GButton(
            icon: Icons.timer_sharp,
            text: 'Habits',
          ),
          GButton(
            icon: Icons.task_alt,
            text: 'Tasks',
          ),
        ],
        onTabChange: (value) => onTabChange!(value),
      ),
    );
  }
}
