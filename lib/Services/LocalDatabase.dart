import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/ReadingHistory.dart';

class LocalDatabase {
  Future<Database> openMyDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'story_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE READING_HISTORY(title TEXT PRIMARY KEY, chap TEXT, date INTEGER)',
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

  Future<List<ReadingHistory>> getData() async {
    final Database db = await openMyDatabase();
    final List<Map<String, dynamic>> maps = await db.query('READING_HISTORY');
    return List.generate(maps.length, (i) {
      return ReadingHistory(
        title: maps[i]['title'],
        chap: maps[i]['chap'],
        date: maps[i]['date'],
      );
    });
  }
}
