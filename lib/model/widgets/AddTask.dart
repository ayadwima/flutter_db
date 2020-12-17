import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_sql/DataBase/DbHelper.dart';
import 'package:shared_sql/screens/FirstScreen.dart';

import '../Task.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final db = DBHelper();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    return Container(
      color: Color(0xFF767676),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add Task',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink, fontSize: 22),
                ),
                TextField(
                  autofocus: true,
                  cursorColor: Colors.pinkAccent,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    newTaskTitle = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Colors.pinkAccent,
                  onPressed: () {
                    db.insertTask(
                        Task(taskName: newTaskTitle, isComplete: false));
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => TodoPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
