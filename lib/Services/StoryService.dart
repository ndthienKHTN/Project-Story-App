import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import '../Models/ChapterPagination.dart';

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
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/listDataSource/'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      List<String> result =  List<String>.from(jsonData['names']);
      return result;
    } else {
      throw Exception("Fail to fetch fetchListNameDataSource");
    }
  }

  Future<List<Story>> fetchSearchStory(String query, String datasource) async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/search/?datasource=$datasource&search=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Story.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch search story');
    }
  }
  Future<Story> fetchDetailStory(String title, String datasource) async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/detailStory/?datasource=$datasource&title=$title'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      Logger logger = Logger();
      logger.i(Story.fromJson(jsonData).toString());
      return Story.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch detail story');
    }
  }
  Future<ContentStory> fetchContentStory(String storyTitle, int chapNumber, String datasource) async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/contentStory/?datasource=$datasource&title=$storyTitle&chap=$chapNumber'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return ContentStory.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch content of story");
    }
  }

  Future<Map<String, List<Story>>> fetchHomeStory(String datasource) async {
      final response = await http.get(Uri.parse('http://localhost:3000/api/v1/home/?datasource=$datasource'));

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        Map<String, List<Story>> mapStories = <String, List<Story>>{};

        jsonData.forEach((category, jsonList) {
          mapStories[category] = parseListStories(jsonList);
        });

        return mapStories;

      } else {
        throw Exception("Failed to fetch home of story");
      }
  }

  List<Story> parseListStories(List<dynamic> jsonList) {
    return jsonList.map((json) => Story.fromJson(json)).toList();
  }

  Future<List<categoryModel.Category>> fetchListCategory(String datasource) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/v1/listCategory/?datasource=$datasource'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.isNotEmpty) {
          List<categoryModel.Category> listCategories = jsonData.map((json) => categoryModel.Category.fromJson(json)).toList();

          return listCategories;
        } else {
          // Trường hợp danh sách trả về rỗng
          throw Exception("Empty list of categories");
        }
      } else {
        // Trường hợp không nhận được response 200 từ server
        throw Exception("Failed to fetch list of category: ${response.statusCode} ");
      }
    } catch (e) {
      // Bắt các lỗi khác có thể xảy ra trong quá trình gọi API
      throw Exception("Failed to fetch list of category: $e");
    }
  }

  Future<ChapterPagination> fetchChapterPagination(String title, int pageNumber, String datasource) async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/listChapter/?datasource=$datasource&title=$title&page=$pageNumber'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return ChapterPagination.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch Chapter Pagination");
    }
  }

}

