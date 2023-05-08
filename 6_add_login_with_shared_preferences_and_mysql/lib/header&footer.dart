// 기본 홈
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memo_app/loginPage/loginMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'communityPage/communityMainPage.dart';
import 'memoPage/memoMainPage.dart';
import 'myInfoPage/myInfoMainPage.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => MyAppState();
}

class MyAppState extends State<MyAppPage> {
  // 바텀 내비게이션 바 인덱스
  int _selectedIndex = 0;

  // 바텀 내비게이션 바의 연결될 페이지를 인덱스 순으로 나열
  final List<Widget> _navIndex = [
    MyMemoPage(),
    CommunityPage(),
    MyInfoPage(),
  ];

  // 바텀 내비게이션 바가 클릭되었을 때 인덱스 상태 변경
  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: const Text('Title'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 로그아웃 기능
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.arrowshape_turn_up_left,
                size: 30,
              ),
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('알림'),
                    content: const Text('로그아웃하시겠습니까?'),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text('아니오'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.remove('token');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => LoginMainPage(),
                            ),
                          );
                        },
                        child: Text('예'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // 본문은 바텀 내비게이션 바의 인덱스에 따라 페이지 전환
      body: _navIndex.elementAt(_selectedIndex),
      // 바텀 내비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_filled),
          //   label: '홈',
          //   backgroundColor: Colors.white,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: '메모',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '내 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),
    );
  }
}
