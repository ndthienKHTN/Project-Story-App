import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import '../Models/ChapterPagination.dart';
import '../Models/ContentStory.dart';
import '../Models/Story.dart';
import '../Models/Category.dart' as categoryModel;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/ContentStory.dart';
import '../Models/Story.dart';


class StoryService {
  Future<List<String>> fetchListNameDataSource() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/listDataSource/'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      List<String> result =  List<String>.from(jsonData['names']);
      return result;
    } else {
      throw Exception("Fail to fetch fetchListNameDataSource");
    }
  }

  Future<List<Story>> fetchSearchStory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/search/?datasource=Truyenfull&search=ta'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Story.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch story');
    }
  }
  Future<Story> fetchDetailStory(String title) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/detailStory/?datasource=Truyenfull&title=$title'));

    if (response.statusCode == 200) {
    final dynamic jsonData = jsonDecode(response.body);
    Logger logger = Logger();
    logger.i(Story.fromJson(jsonData).toString());
    return Story.fromJson(jsonData);
    } else {
    throw Exception('Failed to fetch story');
    }
  }
  Future<ContentStory> fetchContentStory(String storyTitle, String chap) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/contentStory/?datasource=Truyenfull&title=$storyTitle&chap=$chap'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return ContentStory.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch content of story");
    }
  }

  Future<Map<String, List<Story>>> fetchHomeStory() async {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/home/?datasource=Truyenfull'));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        Map<String, List<Story>> mapStories = <String, List<Story>>{};

        jsonData.forEach((category, jsonList) {
          mapStories[category] = parseListStories(jsonList);
        });

        return mapStories;

      } else {
        throw Exception("Failed to fetch content of story");
      }
  }

  List<Story> parseListStories(List<dynamic> jsonList) {
    return jsonList.map((json) => Story.fromJson(json)).toList();
  }

  Future<List<categoryModel.Category>> fetchListCategory(String datasource) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/listCategory/?datasource=Truyenfull'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<categoryModel.Category> listCategories =  (jsonData.map((json) => categoryModel.Category.fromJson(json))).toList();
      Logger logger = Logger();
      logger.i(listCategories[0].toString());
      return listCategories;
    } else {
      throw Exception("Failed to fetch content of story");
    }
  }

  Future<ChapterPagination> fetchChapterPagination(String datasource, String title, String pageNumber) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/listChapter/?datasource=Truyenfull&title=vo-than-chua-te&page=1'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return ChapterPagination.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch Chapter Pagination");
    }
  }

}
