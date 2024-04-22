import 'package:project_login/Models/Story.dart';

class ContentStory {
  late  String name;
  late String content;
  late String chap;
  late String title;

  ContentStory({required this.name,
                required this.title,
                required this.chap,
                required this.content});
  @override
  String toString() {
    return "Story{name:$name}";
  }

  factory ContentStory.fromJson(Map<String, dynamic> json) {
    return ContentStory(name: json['name'],
                        title: json['title'],
                        chap: json['chap'],
                        content: json['content']);
  }
}