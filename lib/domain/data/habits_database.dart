import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  List habitList = [];
  final _habitsBox = Hive.box('habits_box');

  void createInitialData(){
    habitList = [
      ['First habit', false, 0, 1],
    ];
  }

  void loadData(){
    habitList = _habitsBox.get('HABITS');
  }

  void updateDatabase(){
    _habitsBox.put('HABITS', habitList);
  }

}