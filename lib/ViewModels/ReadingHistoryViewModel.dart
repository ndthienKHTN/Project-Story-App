import 'package:flutter/cupertino.dart';
import 'package:project_login/Models/ReadingHistory.dart';

import '../Services/LocalDatabase.dart';

class ReadingHistoryViewModel extends ChangeNotifier {
  LocalDatabase localDatabase = LocalDatabase();

  List<ReadingHistory>? readingHistoryList = [];

  Future<void> fetchReadingHistoryList() async{
    readingHistoryList = await localDatabase.getReadingHistoryList();
    readingHistoryList?.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }
}