import 'package:flutter/cupertino.dart';
import '../Models/Story.dart';
import '../Services/StoryService.dart';


class HomeStoryViewModel extends ChangeNotifier {
  final StoryService _storyService = StoryService();
  Map<String, List<Story>> _stories = <String, List<Story>>{};
  Map<String, List<Story>> get stories => _stories;
  List<String> sourceBooks=[];
  late String sourceBook;
  int indexSourceBook=0;
  bool listOn=true;

  Future<void> fetchHomeStories() async {
    try {
      _stories.clear();
      _stories = await _storyService.fetchHomeStory();
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching stories: $e');
    }
  }

  Future<void> fetchHomeSourceBooks() async{
    try{
      sourceBooks.clear();
      sourceBooks= await _storyService.fetchListNameDataSource();
      if(sourceBooks.isNotEmpty){
        sourceBook=sourceBooks[0];
      }
      notifyListeners();
    }
    catch (e) {
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

  void Reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String item = sourceBooks.removeAt(oldIndex);
    sourceBooks.insert(newIndex, item);
    notifyListeners();
  }

  void Changeindex(int newIndex){
    indexSourceBook=newIndex;
    notifyListeners();
  }

  void UpdateSource(List<String> newSourceBooks){
    sourceBooks.clear();
    sourceBooks.addAll(newSourceBooks);
    notifyListeners();
  }
}