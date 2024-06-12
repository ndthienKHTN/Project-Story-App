import 'package:flutter/cupertino.dart';
import 'package:project_login/Models/DownloadHistory.dart';

import '../Models/ReadingHistory.dart';
import '../Services/LocalDatabase.dart';

class DownloadHistoryViewModel extends ChangeNotifier {
  final LocalDatabase _localDatabase = LocalDatabase();

  List<DownloadHistory> _downloadHistoryList = [];
  List<DownloadHistory> get downloadHistoryList => _downloadHistoryList;

  Future<void> fetchDownloadList() async{
    _downloadHistoryList = await _localDatabase.getDownloadHistoryList();
    _downloadHistoryList.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }
}