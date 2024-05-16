import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_login/Models/ChapterPagination.dart';
import 'package:project_login/Models/ReadingHistory.dart';
import 'package:project_login/Services/LocalDatabase.dart';
import 'package:project_login/Models/ContentDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_login/Models/ContentDisplay.dart';
import 'package:yaml/yaml.dart';

import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';

class ContentStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  final LocalDatabase _localDatabase = LocalDatabase();

  ContentStory? _contentStory;
  ContentDisplay contentDisplay = ContentDisplay.defaults();
  List<String> _fontNames =
      []; // list of fonts user can choose to change display of content story
  int indexChapter = 0; // to get the index of current chapter in chapterList
  List<String> sourceBooks = []; // list of data source app can get story from
  int _indexSource =
      0; // to get the index of current source in sourceBooks (only using when automatically change source)
  String currentSource = '';
  List<String> formatList = []; // list of format user can choose when download
  ChapterPagination chapterPagination = ChapterPagination.defaults();

  // chapterPagination change when user see chapter in ChooseChapterBottomSheet so we need this variable to track current page number
  int currentPageNumber = 0;

  ContentStory? get contentStory => _contentStory;

  List<String> get fontNames => _fontNames;

  Future<void> fetchContentStory(
      String dataSource, String storyTitle, String chap) async {
    try {
      _contentStory =
          await _storyService.fetchContentStory(dataSource, storyTitle, chap);
      _indexSource = 0;
      print(currentPageNumber.toString());
      print(chap);

      // calculate indexChapter
      for (int i = 0; i < chapterPagination.listChapter!.length; i++) {
        if (chapterPagination.listChapter?[i].content == chap) {
          indexChapter = i;
          break;
        }
      }
      print(indexChapter.toString());
      // save current data source
      currentSource = dataSource;
      notifyListeners();

      // insert reading history to local database
      int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
      // tạm comment
      // _localDatabase.insertData(ReadingHistory(title: storyTitle, chap: chap, date: currentTimeMillis));
    } catch (e) {
      print('Error fetching story content source $dataSource: $e');
      fetchContentStory(sourceBooks[_indexSource++], storyTitle, chap);
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

  Future<void> fetchSourceBooks() async {
    try {
      //sourceBooks= await _storyService.fetchListNameDataSource();
      sourceBooks = await ['Truyen123', 'Truyenfull', 'Truyenmoi'];
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching source book: $e');
    }
  }

  Future<void> fetchFormatList() async {
    try {
      formatList = await ['pdf', 'txt', 'epub', 'prc'];
      notifyListeners();
    } catch (e) {
      print('Error fetching format list: $e');
    }
  }

  Future<void> fetchChapterPagination(
      String dataSource, String title, int page, bool changePageNumber) async {
    try {
      chapterPagination = await _storyService.fetchChapterPagination(
          dataSource, title, page.toString());
      if (changePageNumber) {
        currentPageNumber = page;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching chapter pagination list: $e');
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
