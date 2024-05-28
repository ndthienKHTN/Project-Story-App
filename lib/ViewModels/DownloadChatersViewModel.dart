
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Services/DownloadService.dart';

class DownloadChaptersViewModel extends ChangeNotifier {
  final DownloadService downloadService = DownloadService();

  List<String> _downloadedTxtFilePath = [];
  List<String> get downloadedTxtFilePath => _downloadedTxtFilePath;
  List<String> _listFileExtension = [];
  List<String> get listFileExtension => _listFileExtension;

  Future<void> downloadChaptersOfStory(String storyTitle, List<String> chapters, String fileType, String datasource) async {
    try {
        _downloadedTxtFilePath.clear();
        for (String chapter in chapters) {
          String filePath = await downloadService.downloadAndUnzipFile(storyTitle, chapter, fileType, datasource);
          _downloadedTxtFilePath.add(filePath);
        }
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