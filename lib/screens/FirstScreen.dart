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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => NewTask(),
                    elevation: 8.0);
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text(
                'My Tasks',
                style: TextStyle(fontSize: 22),
              ),
              backgroundColor: Colors.deepPurpleAccent,
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
            body: TabBarView(
              children: [
                AllTasksScreen(),
                CompleteTasksScreen(),
                InCompleteTasksScreen()
              ],
            )));
  }
}
