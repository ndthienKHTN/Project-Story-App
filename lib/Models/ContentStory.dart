import 'package:project_login/Models/Story.dart';

class ContentStory {
  late  String name;
  late String content;
  late String chap;
  late String title;
  late String? chapterTitle;
  late String author;
  late String cover;

  ContentStory({required this.name,
                required this.title,
                required this.chap,
                required this.content,
                this.chapterTitle,
                required this.author,
                required this.cover});


  @override
  String toString() {
    return 'ContentStory{name: $name, chap: $chap, title: $title, chapterTitle: $chapterTitle, author: $author, cover: $cover, content: $content}';
  }

  factory ContentStory.fromJson(Map<String, dynamic> json) {
    return ContentStory(name: json['name'],
                        title: json['title'],
                        chap: json['chap'],
                        content: json['content'],
                        chapterTitle: json.containsKey("chapterTitle") ? json['chapterTitle'] : null,
                        author: json['author'],
                        cover: json['cover']);
  }
}