import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_login/Views/ContentDisplay.dart';
import 'package:yaml/yaml.dart';

import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';


class ContentStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  ContentStory? _contentStory;
  ContentDisplay contentDisplay = ContentDisplay.defaultDisplay();

  ContentStory? get contentStory => _contentStory;

  Future<void> fetchContentStory(String storyTitle) async {
    try {
      _contentStory = await _storyService.fetchContentStory(storyTitle);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story content: $e');
    }
  }

  Future<void> fetchContentDisplay(String storyTitle) async {
    try {
      List<String> fontLists = await getFontFileNames();
      contentDisplay = await ContentDisplay(20, 2, fontLists);
      //contentDisplay.fontLists = await getFontFileNames();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story content: $e');
    }
  }

  Future<List<String>> getFontFileNames() async {
    return ['Item1', 'Item2'];
  }
  //   try {
  //     // Đọc tệp pubspec.yaml
  //     File file = File('pubspec.yaml');
  //     String yamlString = await file.readAsString();
  //
  //     // Phân tích cú pháp YAML
  //     var yamlMap = loadYaml(yamlString);
  //
  //     // Lấy danh sách các font từ YAML
  //     List<dynamic> fontList = yamlMap['fonts'];
  //
  //     // Khởi tạo danh sách để lưu trữ tên font
  //     List<String> fontNames = [];
  //
  //     // Lặp qua mỗi mục trong danh sách font và lấy tên font
  //     for (var fontEntry in fontList) {
  //       fontNames.add(fontEntry['family']);
  //     }
  //
  //     return fontNames;
  //   } catch (e) {
  //     print('Đã xảy ra lỗi: $e');
  //     return []; // Trả về một danh sách trống nếu có lỗi
  //   }
  // }
}
