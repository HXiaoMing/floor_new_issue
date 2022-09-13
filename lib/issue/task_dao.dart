import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:floor_issue/issue/task.dart';
import 'package:floor_issue/main.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM ${Task.tableName} WHERE id = :id')
  Future<Task?> findTaskById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTask(Task task);

  @Query('UPDATE ${Task.tableName} SET data = :data WHERE id = :id')
  Future<void> updateData(Uint8List data, int id);

  Future<void> rawUpdateData(Uint8List data, int id) {
    return database.database.rawUpdate(
        'UPDATE ${Task.tableName} SET data = ? WHERE id = ?', [data, id]);
  }
}
