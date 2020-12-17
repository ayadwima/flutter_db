import 'package:sqflite/sqflite.dart';
import 'package:shared_sql/model/Task.dart';

class DBHelper {
   Database database;
  static final String dbName = '/toDoDb.db';
  static final String tableName = 'tasks';
  static final String columnId = 'id';
  static final String columnName = 'name';
  static final String columnIsComplete = 'iscomplete';

  Future<Database> initDataBase() async {
    if (database == null) {
      return await createDataBase();
    } else {
      return database;
    }
  }

  createDataBase() async {
    try {
      String dbPath = await getDatabasesPath();
      String path = dbPath + dbName;
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT , $columnName TEXT, $columnIsComplete INTEGER)');
      });
      return database;
    } catch (e) {
      print(e);
    }
  }

  insertTask(Task task) async {
    try {
      database = await initDataBase();
      await database.insert(tableName, task.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map>> getAllTasks() async {
    database = await initDataBase();
    List<Map> resault = await database.query(tableName);
    return resault;
  }

  Future<List<Map>> getTaskType(int isComplete) async {
    try {
      database = await initDataBase();
      List<Map> resault = await database.query(tableName,
          where: '$columnIsComplete=?', whereArgs: [isComplete]);
      return resault;
    } catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDataBase();
      database.update(tableName, task.toJson(),
          where: '$columnId=?', whereArgs: [task.id]);
    } catch (e) {}
  }

  deleteTask(int id) async {
    try {
      database = await initDataBase();
      database.delete(tableName, where: '$columnId=?', whereArgs: [id]);
    } catch (e) {}
  }
}
