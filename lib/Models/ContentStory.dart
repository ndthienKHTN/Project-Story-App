import 'package:project_login/Models/Story.dart';

class ContentStory {
  late  String name;
  late String content;
  late String chap;
  late String title;
  late String? chapterTitle;

  ContentStory({required this.name,
    required this.title,
    required this.chap,
    required this.content,
    this.chapterTitle});


  @override
  String toString() {
    return 'ContentStory{name: $name, content: $content, chap: $chap, title: $title, chapterTitle: $chapterTitle}';
  }

  factory ContentStory.fromJson(Map<String, dynamic> json) {
    return ContentStory(name: json['name'],
        title: json['title'],
        chap: json['chap'],
        content: json['content'],
        chapterTitle: json.containsKey("chapterTitle") ? json['chapterTitle'] : null);
  }
}