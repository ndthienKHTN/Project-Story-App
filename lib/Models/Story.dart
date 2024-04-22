import 'package:flutter/cupertino.dart';

class Story {
   String name;
   String link;
   String cover;
   String author;

 /*  Story(String name, String cover, String link, String author) {
     name = name;
     link = link;
     cover = cover;
     author = author;
   }*/

   Story({required this.name,
         required this.cover,
         required this.link,
         required this.author});

   @override
   String toString() {
     return "Story{name:$name}";
   }

   factory Story.fromJson(Map<String, dynamic> json) {
     return Story(name: json['name'],
                 cover: json['cover'],
                 link: json['link'],
                 author: json['author']);
   }
}