
import 'package:flutter/cupertino.dart';

import '../Models/Story.dart';
import '../Services/StoryService.dart';

class DetailStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();

  Story? _story;
  Story? get story => _story;

  Future<void> fetchStoryDetails(String title) async {
    try {
      // Fetch story details from the API using the storyId
      _story = await _storyService.fetchDetailStory(title);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story details: $e');
    }
  }
}