import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_sql/Provider/app_provider.dart';
import 'screens/FirstScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) {
      return AppProvider();
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    ),
  ));
}
