import 'package:floor/floor.dart';
import 'package:flutter/services.dart';

@Entity(tableName: Task.tableName)
class Task {
  static const tableName = 'Task';

  @primaryKey
  final int id;

  final Uint8List data;

  Task(this.id, this.data);

  @override
  String toString() {
    return 'Task{id: $id, len: ${data.length}';
  }
}
