// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_memo_app/loginPage/loginMainPage.dart';
import 'package:flutter_memo_app/memoPage/memoListProvider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  // 플러터 바인딩 초기화 및 바인딩 설정 체크
  WidgetsFlutterBinding.ensureInitialized();
  // 모바일 광고 SDK 초기화
  MobileAds.instance.initialize();
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
      home: SafeArea(
        child: TokenCheck(),
      ),
    );
  }
}
