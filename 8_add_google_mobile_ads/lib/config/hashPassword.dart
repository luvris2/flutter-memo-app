import 'package:crypto/crypto.dart'; // password hashing algorithms
import 'dart:convert'; // for the utf8.encode method

String hashPassword(String password) {
  const uniqueKey = 'eunbyeol'; // 비밀번호 추가 암호화를 위해 유니크 키 추가
  final bytes = utf8.encode(password + uniqueKey); // 비밀번호와 유니크 키를 바이트로 변환
  final hash = sha256.convert(bytes); // 비밀번호를 sha256을 통해 해시 코드로 변환
  return hash.toString();
}
