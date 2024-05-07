import 'package:flutter/cupertino.dart';

import '../Models/Category.dart';
import '../Services/StoryService.dart';

class ChoiseCategoryViewModel extends ChangeNotifier{
  final StoryService _storyService = StoryService();
  List<Category>? _categories;

  List<Category>? get categories => _categories;

  Future<void> fetchCategories(String datasource) async {
    try {
      // Fetch list category from the API using the name data source
      _categories = await _storyService.fetchListCategory(datasource);
      _categories?.forEach((element) {print(element.content);});
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching story details: $e');
    }
  }
}