import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Models/ChapterPagination.dart';
import 'package:project_login/Models/ReadingHistory.dart';
import 'package:project_login/Services/LocalDatabase.dart';
import 'package:project_login/Models/ContentDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Models/ChapterPagination.dart';
import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';

class ContentStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  final LocalDatabase _localDatabase = LocalDatabase();
  late final SharedPreferences prefs;

  ContentStory? _contentStory;
  ContentDisplay contentDisplay = ContentDisplay.defaults();
  List<String> _fontNames =
      []; // list of fonts user can choose to change display of content story
  int currentChapNumber = 1;
  List<String> sourceBooks = []; // list of data source app can get story from
  int _indexSource =
      0; // to get the index of current source in sourceBooks (only using when automatically change source)
  String currentSource = '';
  List<String> formatList = []; // list of format user can choose when download
  ChapterPagination _chapterPagination = ChapterPagination.defaults();

  ChapterPagination get chapterPagination => _chapterPagination;

  // chapterPagination change when user see chapter in ChooseChapterBottomSheet
  // so we need this variable to track page number of current chapter
  int currentPageNumber = 1;

  ContentStory? get contentStory => _contentStory;

  List<String> get fontNames => _fontNames;

  void setPreferences(SharedPreferences sharedPreferences) {
    prefs = sharedPreferences;
  }

  Future<bool> fetchContentStory(String storyTitle, int chapNumber,
      String dataSource, String chosenDataSource) async {
    try {
      print('storyTitle: $storyTitle');
      print('chapNumber: $chapNumber');
      print('datasource: $dataSource');
      _contentStory = await _storyService.fetchContentStory(
          storyTitle, chapNumber, dataSource);
      // Logger logger = Logger();
      // logger.i(_contentStory.toString());
      _indexSource = 0;
      print(currentPageNumber.toString());
      print(chapNumber);
      currentChapNumber = chapNumber;

      // save current data source
      currentSource = dataSource;
      notifyListeners();

      // reload chapterPagination when navigate to next or previous chapter
      // or reload when fetching chapterPagination failed
      if (currentPageNumber != chapterPagination.currentPage || chapterPagination.currentPage == 0) {
        fetchChapterPagination(storyTitle, currentPageNumber, dataSource, true);
      }

      // insert reading history to local database
      int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
      _localDatabase.insertData(ReadingHistory(
          pageNumber: currentPageNumber,
          title: _contentStory!.title,
          name: _contentStory!.name,
          chap: chapNumber,
          date: currentTimeMillis,
          author: _contentStory!.author,
          cover: _contentStory!.cover,
          dataSource: currentSource));
      return (dataSource == chosenDataSource);
    } catch (e) {
      print('Error fetching story content source $dataSource: $e');
      return fetchContentStory(storyTitle, chapNumber,
          sourceBooks[_indexSource++], chosenDataSource);
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

      int? isTesting = await getInt(IS_TESTING_KEY);

      if (isTesting != 1){
        _fontNames = fonts.map<String>((font) => font().fontFamily!).toList();
      }

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

  Future<void> fetchChapterPagination(String storyTitle, int pageNumber,
      String datasource, bool changePageNumber) async {
    try {
      print('storyTitle: $storyTitle');
      print('pageNumber: $pageNumber');
      print('datasource: $datasource');
      // Fetch story details from the API using the storyId
      _chapterPagination = await _storyService.fetchChapterPagination(
          storyTitle, pageNumber, datasource);
      if (changePageNumber) {
        currentPageNumber = pageNumber;
      }
      Logger logger = Logger();
      logger.i(_chapterPagination.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching chapter pagination list: $e');
    }
  }

  Future<void> fetchSourceBooks() async {
    try {
      List<String> sourceBooksApi =
          await _storyService.fetchListNameDataSource();
      List<String>? sourceBooksLocal = [];
      sourceBooksLocal = await getStringList("LIST_SOURCE");
      if (sourceBooksLocal == null) {
        // if user don't save order of source in local, use order in api
        sourceBooks = sourceBooksApi;
      } else {
        sourceBooks = sourceBooksLocal;
        // remove old source in SharePreferences from sourceBooks
        for (int i = 0; i < sourceBooksLocal.length; i++) {
          if (!sourceBooksApi.contains(sourceBooksLocal[i])) {
            sourceBooks.removeAt(i);
            i--;
          }
        }
        // add all new source in api to sourceBooks
        for (int i = 0; i < sourceBooksApi.length; i++) {
          if (!sourceBooks.contains(sourceBooksApi[i])) {
            sourceBooks.add(sourceBooksApi[i]);
          }
        }
      }
      // save order of source to SharePreferences
      saveStringList("LIST_SOURCE", sourceBooks);
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

  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  Future<String?> getString(String key) async {
    return prefs.getString(key);
  }

  Future<int?> getInt(String key) async {
    return prefs.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    return prefs.getDouble(key);
  }

  Future<List<String>?> getStringList(String key) async {
    // Lấy chuỗi JSON từ SharedPreferences
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      // Nếu có chuỗi JSON, chuyển đổi nó thành List<String>
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => item.toString()).toList();
    }
    // Trả về null nếu không tìm thấy hoặc có lỗi
    return null;
  }

  Future<void> saveStringList(String key, List<String> valueList) async {
    // Chuyển đổi List<String> thành một chuỗi JSON trước khi lưu vào SharedPreferences
    final jsonString = jsonEncode(valueList);
    await prefs.setString(key, jsonString);
  }
}
