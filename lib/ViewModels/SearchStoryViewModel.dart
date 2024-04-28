
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Models/Story.dart';
import 'package:project_login/Services/StoryService.dart';
import 'dart:async';

class SearchStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  List<Story> _stories = [];
  List<Story> get stories => _stories;

  Future<void> fetchSearchStories(String query, String datasource) async {
    try {
      _stories = await _storyService.fetchSearchStory(query,datasource);
      Logger logger = Logger();
      logger.i(stories[0].toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching stories: $e');
    }
  }
}
/*
class StoryViewModel {
  final StoryService _storyService = StoryService();
  List<Story> _stories = [];

  List<Story> get stories => _stories;


  final StreamController<List<Story>> _storyStreamController =
  StreamController<List<Story>>.broadcast();

  Stream<List<Story>> get storyStream => _storyStreamController.stream;

  Future<void> fetchStory() async {
    try {
      _stories = await _storyService.fetchSearchStory();
      _storyStreamController.add(_stories); // Emit the updated list of stories
      Logger logger = Logger();
      logger.i(_stories.length);
      logger.i(_stories[0].toString());
    } catch (e) {
        print(e);
    }
  }

  void dispose() {
    _storyStreamController.close(); // Close the stream controller
  }

}*/
