
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_login/Models/DownloadHistory.dart';
import 'package:project_login/Services/DownloadService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

import '../Services/LocalDatabase.dart';
import '../Services/StoryService.dart';

class DownloadChaptersViewModel extends ChangeNotifier {
  final DownloadService downloadService = DownloadService();
  final LocalDatabase _localDatabase = LocalDatabase();

  List<String> _downloadedTxtFilePath = [];
  List<String> get downloadedTxtFilePath => _downloadedTxtFilePath;

  List<String> _listFileExtension = [];
  List<String> get listFileExtension => _listFileExtension;


  Future<void> downloadChaptersOfStory(String storyTitle,String cover, List<int> chapters, String fileType, String datasource) async {
    try {
        _downloadedTxtFilePath.clear();
        for (int chapter in chapters) {
          String filePath = await downloadService.downloadAndUnzipFile(storyTitle, chapter, fileType, datasource);
          Logger logger = Logger();
          logger.i("File path" + filePath);
          _downloadedTxtFilePath.add(filePath);
        }
        // insert reading history to local database
        int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
        _localDatabase.insertDataDownload(DownloadHistory(
            title: storyTitle,
            date: currentTimeMillis,
            cover: cover,
            dataSource: datasource));
        notifyListeners();
    } catch (e) {
      // Handle error
      print('Error download chapters of story: $e');
    }
  }
  Future<void> fetchListFileExtension() async{
    try {
      _listFileExtension = await downloadService.fetchListFileExtension();
      Logger logger = Logger();
      logger.i(_listFileExtension);
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error can not fetch list file extension: $e");
    }
  }


}