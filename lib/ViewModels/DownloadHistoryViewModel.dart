import 'package:flutter/cupertino.dart';
import 'package:project_login/Models/DownloadHistory.dart';
import '../Services/LocalDatabase.dart';

class DownloadHistoryViewModel extends ChangeNotifier {
  LocalDatabase localDatabase = LocalDatabase();

  List<DownloadHistory> _downloadHistoryList = [];
  List<DownloadHistory> get downloadHistoryList => _downloadHistoryList;


  Future<void> fetchDownloadList() async{
    _downloadHistoryList = await localDatabase.getDownloadHistoryList();
    _downloadHistoryList.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> deleteDownloadChapter(String link) async {
    localDatabase.deleteDataDownloadByLink(link);
    notifyListeners();
  }
}