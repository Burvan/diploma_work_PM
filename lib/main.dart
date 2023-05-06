import 'package:diplom_work/ui/themes/shared_prefs.dart';
import 'package:diplom_work/ui/widgets/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  await Hive.initFlutter();
  var box = await Hive.openBox('tasks_box');
  var expenseBox = await Hive.openBox('expense_box');

  runApp(const MyDiplomApp());
}