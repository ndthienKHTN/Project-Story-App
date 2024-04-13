
import 'package:logger/logger.dart';
import 'package:project_login/Models/Story.dart';
import 'package:project_login/Services/StoryService.dart';
import 'dart:async';

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
      /*var temp = _stories[0].toString();
      logger.i(temp);*/
    } catch (e) {
        print(e);
    }
  }

  void dispose() {
    _storyStreamController.close(); // Close the stream controller
  }

}