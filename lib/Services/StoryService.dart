import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/ContentStory.dart';
import '../Models/Story.dart';

class StoryService {
  Future<List<Story>> fetchSearchStory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/search/?datasource=Truyen123&search=ta'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Story.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch story');
    }
  }
  Future<Story> fetchDetailStory(String title) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/detailStory/?datasource=Truyen123&title=choc-tuc-vo-yeu-mua-mot-tang-mot'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return Story.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch story');
    }
  }
  Future<ContentStory> fetchContentStory(String storyTitle) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/contentStory/?datasource=Truyen123&title=choc-tuc-vo-yeu-mua-mot-tang-mot&chap=1'));

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      return ContentStory.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch content of story");
    }
  }
  
  Future<Map<String, List<Story>>> fetchHomeStory() async {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/home/?datasource=Truyen123'));

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
  
}
