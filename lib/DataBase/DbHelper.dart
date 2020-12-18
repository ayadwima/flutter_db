import 'package:sqflite/sqflite.dart';
import 'package:shared_sql/model/Task.dart';

class DBHelper {
  Database database;
  static final String dbName = '/sql.db';
  static final String nameTable = 'tasksUser';
  static final String idColumn = 'id';
  static final String nameColumn = 'name';
  static final String isCompleteColumn = 'iscomplete';

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
            'CREATE TABLE $nameTable ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT , $nameColumn TEXT, $isCompleteColumn  INTEGER)');
      });
      return database;
    } catch (e) {
      print(e);
    }
  }

  insertTask(UserTask task) async {
    try {
      database = await initDataBase();
      await database.insert(nameTable, task.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map>> getAllTasks() async {
    database = await initDataBase();
    List<Map> resault = await database.query(nameTable);
    return resault;
  }

  Future<List<Map>> getTaskType(int isComplete) async {
    try {
      database = await initDataBase();
      List<Map> resault = await database.query(nameTable,
          where: '$isCompleteColumn=?', whereArgs: [isComplete]);
      return resault;
    } catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDataBase();
      database.delete(nameTable, where: '$idColumn=?', whereArgs: [id]);
    } catch (e) {}
  }

  updateTask(UserTask task) async {
    try {
      database = await initDataBase();
      database.update(nameTable, task.toJson(),
          where: '$idColumn=?', whereArgs: [task.id]);
    } catch (e) {}
  }
}
