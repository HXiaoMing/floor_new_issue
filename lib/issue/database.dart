import 'dart:async';
import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:floor_issue/issue/task.dart';
import 'package:floor_issue/issue/task_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
