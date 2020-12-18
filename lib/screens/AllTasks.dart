import 'package:flutter/material.dart';
import 'package:shared_sql/DataBase/DbHelper.dart';
import 'package:shared_sql/model/Task.dart';

import 'FirstScreen.dart';

class AllTasksScreen extends StatefulWidget {
  @override
  _AllTasksScreenState createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    var db = DBHelper();
    var allTasks = db.getAllTasks();
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List>(
          future: allTasks,
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, int position) {
                      final item = snapshot.data[position];
                      bool isComplete = false;
                      if (snapshot.data[position].row[2] == 1) {
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
                                    Widget cancelButton = FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueButton = FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        db.deleteTask(
                                            snapshot.data[position].row[0]);
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TodoPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    );

                                    AlertDialog alert = AlertDialog(
                                      title: Text("Delete Task?"),
                                      content: Text(
                                          "Are you want to delete this Task?"),
                                      actions: [
                                        cancelButton,
                                        continueButton,
                                      ],
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              title: Text(snapshot.data[position].row[1]),
                              trailing: Checkbox(
                                  activeColor: Colors.deepPurpleAccent,
                                  value: isComplete,
                                  onChanged: (value) {
                                    setState(() {
                                      db.updateTask(UserTask(
                                        id: snapshot.data[position].row[0],
                                        taskUser:
                                            snapshot.data[position].row[1],
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
