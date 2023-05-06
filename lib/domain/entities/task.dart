import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task{
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  bool isFavourite;

  Task({
    required this.taskName,
    required this.isDone,
    required this.isFavourite
  });


}