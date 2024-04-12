import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Story.dart';

class StoryService {
  Future<List<Story>> fetchStory() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/v1/search/?datasource=Truyen123&search=ta'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Story.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch story');
    }
  }
}
