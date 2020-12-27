import 'package:flutter/material.dart';
import 'package:shared_sql/DataBase/DbHelper.dart';
import 'package:shared_sql/model/Task.dart';
class AppProvider extends ChangeNotifier {
   var db = DBHelper();
  getTasks(String name, String address) {        
    notifyListeners();
   var allTasks = db.getAllTasks();
    
  }
}
