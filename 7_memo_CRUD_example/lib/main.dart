// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_memo_app/loginPage/loginMainPage.dart';
import 'package:flutter_memo_app/memoPage/memoListProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemoUpdator()),
      ],
      child: const MyApp(),
    ),
  );
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
