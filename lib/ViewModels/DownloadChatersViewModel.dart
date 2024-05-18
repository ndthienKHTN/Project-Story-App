
import 'package:flutter/cupertino.dart';
import 'package:project_login/Services/DownloadService.dart';

class DownloadChaptersViewModel extends ChangeNotifier {
  final DownloadService downloadService = DownloadService();

  List<String> _downloadedTxtFilePath = [];
  List<String> get downloadedTxtFilePath => _downloadedTxtFilePath;


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

}