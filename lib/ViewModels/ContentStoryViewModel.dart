import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_login/Models/ChapterPagination.dart';
import 'package:project_login/Models/ReadingHistory.dart';
import 'package:project_login/Services/LocalDatabase.dart';
import 'package:project_login/Views/ContentDisplayView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_login/Views/ContentDisplayView.dart';
import 'package:yaml/yaml.dart';

import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';

class ContentStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  final LocalDatabase _localDatabase = LocalDatabase();

  ContentStory? _contentStory;
  ContentDisplay contentDisplay = ContentDisplay.defaults();

  ContentStory? get contentStory => _contentStory;
  List<String> _fontNames = [];
  List<String> fakedatas = [];
  int index = 0;

  List<String> get fontNames => _fontNames;

  Future<void> fetchContentStory(String storyTitle, String chap) async {
    try {
      _contentStory = await _storyService.fetchContentStory(storyTitle, chap);
      fakedatas = [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
      ];
      for (int i = 0; i < fakedatas.length; i++) {
        if (fakedatas[i] == chap) {
          index = i;
          break;
        }
      }
      notifyListeners();

      // insert reading history to local database
      int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
      // tạm comment
      // _localDatabase.insertData(ReadingHistory(title: storyTitle, chap: chap, date: currentTimeMillis));
    } catch (e) {
      // Handle error
      print('Error fetching story content: $e');
    }
  }

  Future<void> fetchContentDisplay() async {
    try {
      double? textSize;
      double? lineSpacing;
      int? textColor;
      int? backgroundColor;
      String? fontFamily;

      await Future.wait([
        getDouble(TEXT_SIZE_KEY).then((value) => textSize = value),
        getDouble(LINE_SPACING_KEY).then((value) => lineSpacing = value),
        getInt(TEXT_COLOR_KEY).then((value) => textColor = value),
        getInt(BACKGROUND_COLOR_KEY).then((value) => backgroundColor = value),
        getString(FONT_FAMILY_KEY).then((value) => fontFamily = value),
      ]);

      _fontNames = fonts.map<String>((font) => font().fontFamily!).toList();
      if (!_fontNames.contains(fontFamily)) {
        if (_fontNames.isNotEmpty) {
          fontFamily = _fontNames[0];
        }
      }

      contentDisplay = ContentDisplay(
          textSize: textSize ?? DEFAULT_TEXT_SZIE,
          lineSpacing: lineSpacing ?? DEFAULT_LINE_SPACING,
          fontFamily: fontFamily ?? DEFAULT_FONT_FAMILY,
          textColor: textColor ?? DEFAULT_TEXT_COLOR,
          backgroundColor: backgroundColor ?? DEFAULT_BACKGROUND_COLOR);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story content: $e');
    }
  }

  Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
}
