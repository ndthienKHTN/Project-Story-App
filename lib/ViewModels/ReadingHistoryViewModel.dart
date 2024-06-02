import 'package:flutter/cupertino.dart';
import 'package:project_login/Models/ReadingHistory.dart';

import '../Services/LocalDatabase.dart';

class ReadingHistoryViewModel extends ChangeNotifier {
  final LocalDatabase _localDatabase = LocalDatabase();

  List<ReadingHistory> _readingHistoryList = [];
  List<ReadingHistory> get readingHistoryList => _readingHistoryList;

  Future<void> fetchReadingHistoryList() async{
    _readingHistoryList = await _localDatabase.getReadingHistoryList();
    _readingHistoryList.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }
}