import 'package:shared_sql/DataBase/DbHelper.dart';

class UserTask {
  int id;
  String taskUser;
  bool isCompleteTask;
  UserTask({this.id, this.taskUser, this.isCompleteTask});
  toJson() {
    return {
      DBHelper.idColumn: this.id,
      DBHelper.nameColumn: this.taskUser,
      DBHelper.isCompleteColumn: this.isCompleteTask ? 1 : 0
    };
  }
}
