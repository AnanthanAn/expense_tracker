import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.brown,
          accentColor: Colors.brown,
          scaffoldBackgroundColor: Colors.white),
      title: 'Expense Tracker',
      home: MainPage(),
    );
  }
}
