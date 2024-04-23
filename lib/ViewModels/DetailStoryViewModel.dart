
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../Models/Story.dart';
import '../Services/StoryService.dart';

class DetailStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();

  Story? _story;
  Story? get story => _story;

  Future<void> fetchDetailsStory(String title) async {
    try {
      // Fetch story details from the API using the storyId
      _story = await _storyService.fetchDetailStory(title);
      Logger logger = Logger();
      logger.i(_story.toString());
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story details: $e');
    }
  }
}