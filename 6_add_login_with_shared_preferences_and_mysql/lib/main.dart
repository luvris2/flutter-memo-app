import 'package:flutter/material.dart';
import 'package:flutter_memo_app/config/mySqlConnector.dart';
import 'package:flutter_memo_app/loginPage/loginMainPage.dart';

void main() {
  dbConnector();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoApp',
      home: TokenCheck(),
    );
  }
}
