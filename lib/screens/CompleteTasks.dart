import 'package:flutter/material.dart';
import 'package:shared_sql/DataBase/DbHelper.dart';
import 'package:shared_sql/model/Task.dart';

import 'FirstScreen.dart';

class CompleteTasksScreen extends StatefulWidget {
  @override
  _CompleteTasksScreenState createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  @override
  Widget build(BuildContext context) {
    var db = DBHelper();
    var completeTasks = db.getTaskType(1);
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List>(
          future: completeTasks,
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, int position) {
                      final task = snapshot.data[position];
                      bool isComplete = false;
                      if (task.row[2] == 1) {
                        isComplete = true;
                      } else {
                        isComplete = false;
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return Container(
                          height: 70,
                          child: Center(
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Widget cancelBtn = FlatButton(
                                      child: Text("NO"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueBtn = FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        db.deleteTask(
                                          task.row[0]);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TodoPage()));
                                      },
                                    );

                                    AlertDialog alertDialog = AlertDialog(
                                      title: Text("Delete Task "),
                                      content: Text(
                                          "Do you want to delete this Task ?"),
                                      actions: [
                                        cancelBtn,
                                        continueBtn,
                                      ],
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alertDialog;
                                      },
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              title: Text(task.row[1]),
                              trailing: Checkbox(
                                  activeColor: Colors.deepPurpleAccent,
                                  value: isComplete,
                                  onChanged: (value) {
                                    setState(() {
                                      db.updateTask(UserTask(
                                        id:task.row[0],
                                        taskUser:
                                           task.row[1],
                                        isCompleteTask: value,
                                      ));
                                    });
                                  }),
                            ),
                          ),
                        );
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
