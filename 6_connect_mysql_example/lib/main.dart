import 'package:flutter/material.dart';
import 'package:flutter_memo_app/config/mysqlConnector.dart';
import 'package:flutter_memo_app/login/loginMainPage.dart';

import 'footer.dart';

void main() {
  dbConnector('test');
  runApp(LoginMainPage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemoApp',
      home: MyAppPage(),
    );
  }
}
