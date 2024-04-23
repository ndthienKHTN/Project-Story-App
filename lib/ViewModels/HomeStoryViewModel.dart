import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../Models/Story.dart';
import '../Services/StoryService.dart';


class HomeStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  Map<String, List<Story>> _stories = <String, List<Story>>{};
  Map<String, List<Story>> get stories => _stories;

  Future<void> fetchHomeStories() async {
    try {
      _stories = await _storyService.fetchHomeStory();
      // Logger logger = Logger();
      // logger.i(stories[0].toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching stories: $e');
    }
  }
}
