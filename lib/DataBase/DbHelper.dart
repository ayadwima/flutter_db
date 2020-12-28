import 'package:sqflite/sqflite.dart';
import 'package:shared_sql/model/Task.dart';

class DBHelper {
  Database db;
  static final String dbName = '/sql.db';
  static final String nameTable = 'tasksUser';
  static final String idColumn = 'id';
  static final String nameColumn = 'name';
  static final String isCompleteColumn = 'iscomplete';

  Future<Database> initDataBase() async {
    if (db == null) {
      return await createDataBase();
    } else {
      return db;
    }
  }

  createDataBase() async {
    try {
      String dbPath = await getDatabasesPath();
      String path = dbPath + dbName;
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $nameTable ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT , $nameColumn TEXT, $isCompleteColumn  INTEGER)');
      });
      return database;
    } catch (e) {
      print(e);
    }
  }

  insertTask(UserTask task) async {
    try {
      db = await initDataBase();
      await db.insert(nameTable, task.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map>> getAllTasks() async {
    db = await initDataBase();
    List<Map> resault = await db.query(nameTable);
    return resault;
  }

  Future<List<Map>> getTaskType(int isComplete) async {
    try {
      db = await initDataBase();
      List<Map> resault = await db.query(nameTable,
          where: '$isCompleteColumn=?', whereArgs: [isComplete]);
      return resault;
    } catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      db = await initDataBase();
      db.delete(nameTable, where: '$idColumn=?', whereArgs: [id]);
    } catch (e) {}
  }

  updateTask(UserTask task) async {
    try {
      db = await initDataBase();
      db.update(nameTable, task.toJson(),
          where: '$idColumn=?', whereArgs: [task.id]);
    } catch (e) {}
  }
}
