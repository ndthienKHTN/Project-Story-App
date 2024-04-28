import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Views/ContentDisplayView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Models/ChapterPagination.dart';
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

  ContentStory? _contentStory;
  ContentDisplay contentDisplay = ContentDisplay.defaults();

  ContentStory? get contentStory => _contentStory;
  List<String> _fontNames = [];

  List<String> get fontNames => _fontNames;

  ChapterPagination? _chapterPagination;
  ChapterPagination? get chapterPagination => _chapterPagination;

  Future<void> fetchContentStory(String storyTitle, int pageNumber, String datasource) async {
    try {
      _contentStory = await _storyService.fetchContentStory(storyTitle, pageNumber, datasource);
      notifyListeners();
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
      print('Error fetching story content display: $e');
    }
  }

  Future<void> fetchChapterPagination(String title, int pageNumber, String datasource) async {
    try {
      // Fetch story details from the API using the storyId
      _chapterPagination = await _storyService.fetchChapterPagination(title,pageNumber,datasource);
      Logger logger = Logger();
      logger.i(_chapterPagination.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching chapter pagination: $e');
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
