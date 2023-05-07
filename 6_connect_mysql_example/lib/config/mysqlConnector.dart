import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_memo_app/config/dbInfo.dart';

Future<void> dbConnector(String queryState) async {
  print("Connecting to mysql server...");

  // MySQL 접속 설정
  final conn = await MySQLConnection.createConnection(
    host: DbInfo.hostName,
    port: DbInfo.portNumber,
    userName: DbInfo.userName,
    password: DbInfo.password,
    databaseName: DbInfo.dbName, // optional
  );

  await conn.connect();

  print("Connected");

  IResultSet? result;
  int id = 1;

  if (queryState == 'selectAll') {
    result = await conn.execute("SELECT * FROM memberTable");
  } else if (queryState == 'select') {
    result = await conn.execute(
        "SELECT * FROM memberTable where id = :idNumber", {"idNumber": id});
  }

  if (result != null && result.isNotEmpty) {
    for (final row in result.rows) {
      print(row.assoc());
    }
  }

  await conn.close();
}
