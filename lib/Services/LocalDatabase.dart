import 'package:project_login/Models/DownloadHistory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Models/ReadingHistory.dart';

class LocalDatabase {
  Future<Database> openMyDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'story_database.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE READING_HISTORY(title TEXT PRIMARY KEY, '
          'name TEXT, chap INTEGER, date INTEGER, author TEXT, '
          'cover TEXT, pageNumber INTEGER, dataSource TEXT)',
        );
        db.execute(
          'CREATE TABLE DOWNLOAD_HISTORY(title TEXT, name TEXT, '
          'date INTEGER,chap INTEGER, cover TEXT, dataSource TEXT, '
              ' link TEXT PRIMARY KEY)',
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

  Future<void> insertDataDownload(DownloadHistory data) async {
    final Database db = await openMyDatabase();
    await db.insert(
      'DOWNLOAD_HISTORY',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteDataDownloadByLink(String link) async {
    final db = await openMyDatabase();
    await db.delete(
      'DOWNLOAD_HISTORY',
      where: 'link = ?',
      whereArgs: [link],
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

  Future<List<DownloadHistory>> getDownloadHistoryList() async {
    final Database db = await openMyDatabase();
    final List<Map<String, dynamic>> maps = await db.query('DOWNLOAD_HISTORY');
    return List.generate(maps.length, (i) {
      return DownloadHistory(
          title: maps[i]['title'],
          name:maps[i]['name'],
          date: maps[i]['date'],
          chap: maps[i]['chap'],
          cover: maps[i]['cover'],
          dataSource: maps[i]['dataSource'],
          link: maps[i]['link']);
    });
  }
}
