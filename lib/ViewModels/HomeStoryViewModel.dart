import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:project_login/Models/Category.dart';

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

  List<Category> _listCategories = <Category>[];
  List<Category> get listCategories => _listCategories;
  Future<void> fetchHomeStories(String datasource) async {
    try {
      _stories = await _storyService.fetchHomeStory(datasource);
      sourceBooks = await _storyService.fetchListNameDataSource();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching home stories: $e');
    }
  }

  Future<void> fetchListCategories(String datasource) async {
    try {
      _listCategories = await _storyService.fetchListCategory(datasource);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching home stories - list categories: $e');
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