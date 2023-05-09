// ignore_for_file: avoid_print
// ignore_for_file: file_names

import 'package:flutter_memo_app/config/mySqlConnector.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 모든 메모 보기
Future<IResultSet?> selectMemoALL() async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 유저 식별 정보 호출
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  // DB에 저장된 메모 리스트
  IResultSet result;

  // 유저의 모든 메모 보기
  try {
    result = await conn.execute(
        "SELECT * FROM memo WHERE userIndex = :token", {"token": token});
    if (result.numOfRows > 0) {
      return result;
    }
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
  // 메모가 없으면 null 값 반환
  return null;
}

// 메모 작성
Future<String?> addMemo(String title, String content) async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 유저 식별 정보 호출
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  // 쿼리 수행 결과 저장 변수
  IResultSet? result;

  // 유저의 아이디를 저장할 변수
  String? userName;

  // 메모 추가
  try {
    // 유저 이름 확인
    result = await conn.execute(
      "SELECT userName FROM users WHERE id = :token",
      {"token": token},
    );

    // 유저 이름 저장
    for (final row in result.rows) {
      userName = row.colAt(0);
    }

    // 메모 추가
    result = await conn.execute(
      "INSERT INTO memo (userIndex, userName, memoTitle, memoContent) VALUES (:userIndex, :userName, :title, :content)",
      {
        "userIndex": token,
        "userName": userName,
        "title": title,
        "content": content
      },
    );
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
  // 예외처리용 에러코드 '-1' 반환
  return '-1';
}

// 메모 수정
Future<void> updateMemo(String id, String title, String content) async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 유저 식별 정보 호출
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');

  // 쿼리 수행 결과 저장 변수
  IResultSet? result;

  print('******************** id : $id');
  print('******************** token : $token');
  print('******************** title : $title');
  // 메모 수정
  try {
    await conn.execute(
        "UPDATE memo SET memoTitle = :title, memoContent = :content where id = :id and userIndex = :token",
        {"id": id, "token": token, "title": title, "content": content});
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
}
