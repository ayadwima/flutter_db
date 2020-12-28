import 'package:flutter/material.dart';
import 'package:shared_sql/model/widgets/AddTask.dart';
import 'package:shared_sql/screens/AllTasks.dart';
import 'package:shared_sql/screens/CompleteTasks.dart';
import 'package:shared_sql/screens/InCompleteTasks.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
         child: Scaffold(
              drawer: Drawer(),
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text('My App'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'All Tasks',
                  ),
                  Tab(
                    text: 'complete Tasks',
                  ),
                  Tab(
                    text: 'incomplete  Tasks',
                  )
                ],
                isScrollable: true,
              ),
            ),
              floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewTask()),
                );
              },
              child: Icon(Icons.add),
            ),
            body: TabBarView(
              children: [AllTasksScreen(), CompleteTasksScreen(), InCompleteTasksScreen()],
            )));
  }
}
