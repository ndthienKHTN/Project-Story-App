import 'package:flutter/foundation.dart';
import '../Models/ContentStory.dart';
import '../Services/StoryService.dart';

class ContentStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  ContentStory? _contentStory;
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
}