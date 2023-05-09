// 선택한 항목의 내용을 보여주는 추가 페이지
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_memo_app/memoPage/memoDB.dart';

class ContentPage extends StatelessWidget {
  final dynamic content;

  ContentPage({Key? key, required this.content}) : super(key: key);

  // 앱 바 메모 수정 버튼을 이용하여 메모를 수정할 제목과 내용
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // 앱 바 메모 수정 클릭 이벤트
  Future<void> updateItemEvent(BuildContext context) {
    // 앱 바 메모 수정 버튼을 이용하여 메모를 수정할 제목과 내용
    final TextEditingController titleController =
        TextEditingController(text: content['memoTitle']);
    final TextEditingController contentController =
        TextEditingController(text: content['memoContent']);

    // 다이얼로그 폼 열기
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('항목 추가하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                ),
              ),
              TextField(
                controller: contentController,
                maxLines: null, // 다중 라인 허용
                decoration: InputDecoration(
                  labelText: '내용',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('수정'),
              onPressed: () {
                String memoTitle = titleController.text;
                String memoContent = contentController.text;
                // 메모 수정
                print('memo : ${content['id']} , $memoTitle , $memoContent');
                updateMemo(content['id'], memoTitle, memoContent);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 상세 보기'),
        actions: [
          IconButton(
            onPressed: () => updateItemEvent(context),
            icon: Icon(Icons.edit),
            tooltip: "메모 수정",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.delete_solid),
            tooltip: "메모 삭제",
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  Text(
                    content['memoTitle'],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('작성자 : ${content['userName']}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('작성일 : ${content['createDate']}')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('수정일 : ${content['updateDate']}')],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Text(
                          content['memoContent'],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
