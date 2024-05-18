
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
class DownloadService {

  Future<String> findTxtFilePath(Archive archive) async {
    for (ArchiveFile file in archive) {
      if (!file.isFile) continue;
      String filePath = file.name;
      if (filePath.toLowerCase().endsWith('.txt')) {
        return filePath;
      }
    }
    throw Exception('No .txt file found in the ZIP archive');
  }

  Future<String> downloadAndUnzipFile(String storyTitle, String chapter, String fileType, String datasource) async {
    String folderName = "DownloadedFile";
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(
        Uri.parse(
          "http://10.0.2.2:3000/api/v1/download/downloadChapter/?datasource=$datasource&title=$storyTitle&chap=$chapter&type=$fileType"
        ));
    HttpClientResponse response = await request.close();
    List<int> bytes = await consolidateHttpClientResponseBytes(response);

    // Unzip the file
    Archive archive = ZipDecoder().decodeBytes(bytes);

    Directory? externalDir = await getExternalStorageDirectory();
    String? externalPath = externalDir?.path;
    Logger logger = Logger();
    logger.i(externalPath);

    // Get the document directory path
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    //logger.i(appDocPath);
    
    // Create the target folder
    String targetFolderPath = '$externalPath/$folderName';
    Directory(targetFolderPath).createSync(recursive: true);



    // Extract the files from the ZIP archive
    for (ArchiveFile file in archive) {
      String filePath = '$targetFolderPath/${file.name}';
      if (file.isFile) {
        List<int> data = file.content as List<int>;
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }

    print('ZIP file extracted successfully to $targetFolderPath');

    // Get the file path of the extracted .txt file
    String txtFilePath = await findTxtFilePath(archive);
    String absoluteTxtFilePath = '$targetFolderPath/$txtFilePath';
    print('Path of the extracted .txt file: $absoluteTxtFilePath');

    // Delete the ZIP file
    /*File zipFile = File('$appDocPath/file.zip');
    if (await zipFile.exists()) {
      await zipFile.delete();
      print('ZIP file deleted successfully');
    }*/

    /*List<String> filePaths = await getAllFilePaths(targetFolderPath);

    for (String str in filePaths) {
      print("file path: $str");
    }*/

    return absoluteTxtFilePath;
  }

  Future<List<String>> getAllFilePaths(String directoryPath) async {
    Directory directory = Directory(directoryPath);
    List<String> filePaths = [];

    if (await directory.exists()) {
      await for (FileSystemEntity entity in directory.list(recursive: true)) {
        if (entity is File) {
          filePaths.add(entity.path);
        }
      }
    }

    return filePaths;
  }
}