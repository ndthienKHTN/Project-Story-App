
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Models/ChapterPagination.dart';
import '../Models/ChapterPagination.dart';
import '../Models/Story.dart';
import '../Services/StoryService.dart';

class DetailStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();

  Story? _story;
  Story? get story => _story;

  ChapterPagination? _chapterPagination;
  ChapterPagination? get chapterPagination => _chapterPagination;

  Story? _changedStory;
  Story? get changedStory => _changedStory;

  Future<void> fetchDetailsStory(String title, String datasource) async {
    try {
      // Fetch story details from the API using the storyId
      _story = await _storyService.fetchDetailStory(title,datasource);
      Logger logger = Logger();
      logger.i(_story.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story details: $e');
    }
  }

  Future<void> fetchChapterPagination(String title, int pageNumber, String datasource) async {
    try {
      // Fetch story details from the API using the storyId
      pageNumber = 2;
      _chapterPagination = await _storyService.fetchChapterPagination(title,pageNumber,datasource);
      print('title: $title');
      print('pageNumber: $pageNumber');
      print('datasource: $datasource');
      Logger logger = Logger();
      logger.i(_chapterPagination.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching chapter pagination: $e');
    }
  }

  Future<void> fetchChangeDetailStoryToThisDataSource(String title, String datasource) async {
    try {
      // Fetch story details from the API using the storyId
      _changedStory = await _storyService.fetchChangeDetailStoryToThisDataSource(title,datasource);
      Logger logger = Logger();
      logger.i(_changedStory.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching change details story to this data source: $e');
    }
  }
}