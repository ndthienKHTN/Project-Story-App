import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../Models/Story.dart';
import '../Services/StoryService.dart';


class HomeStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  Map<String, List<Story>> _stories = <String, List<Story>>{};
  Map<String, List<Story>> get stories => _stories;
  List<String> sourceBooks=[];
  String sourceBook='';
  int indexSourceBook=0;
  bool listOn=true;

  Future<void> fetchHomeStories() async {
    try {
      _stories = await _storyService.fetchHomeStory();
      sourceBooks = await _storyService.fetchListNameDataSource();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching stories: $e');
    }
  }


  void ChangeSourceBook(String newSourceBook){
    this.sourceBook=newSourceBook;
    notifyListeners();
  }

  void ChangeListOrGrid(bool listchange){
    listOn=listchange;
    notifyListeners();
  }

  void ChangeIndex(int newIndex){
    this.indexSourceBook=newIndex;
    notifyListeners();
  }
}