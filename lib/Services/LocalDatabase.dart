import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/ReadingHistory.dart';

class LocalDatabase {
  Future<Database> openMyDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'story_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE READING_HISTORY(title TEXT PRIMARY KEY, '
              'name TEXT, chap INTEGER, date INTEGER, author TEXT, '
              'cover TEXT, pageNumber INTEGER, dataSource TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(ReadingHistory data) async {
    final Database db = await openMyDatabase();
    await db.insert(
      'READING_HISTORY',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ReadingHistory>>? getReadingHistoryList() async {
    final Database db = await openMyDatabase();
    final List<Map<String, dynamic>> maps = await db.query('READING_HISTORY');
    return List.generate(maps.length, (i) {
      return ReadingHistory(
          pageNumber: maps[i]['pageNumber'],
          title: maps[i]['title'],
          name: maps[i]['name'],
          chap: maps[i]['chap'],
          date: maps[i]['date'],
          author: maps[i]['author'],
          cover: maps[i]['cover'],
          dataSource: maps[i]['dataSource']);
    });
  }
}
