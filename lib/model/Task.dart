import 'package:shared_sql/DataBase/DbHelper.dart';

class Task {
  int id;
  String taskName;
  bool isComplete;
  Task({this.id, this.taskName, this.isComplete});
  toJson() {
    return {
      DBHelper.columnId: this.id,
      DBHelper.columnName: this.taskName,
      DBHelper.columnIsComplete: this.isComplete ? 1 : 0
    };
  }
}
