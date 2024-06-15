import 'package:flutter_test/flutter_test.dart';
import 'package:project_login/Models/Category.dart';
import 'package:project_login/Models/Story.dart';


void main() {
  group('Story', () {
    test('fromJson should create a Story object from JSON', () {
      final json = {
        'name': 'Story Name',
        'cover': 'Cover URL',
        'link': 'Link URL',
        'title': 'Story Title',
        'description': 'Story Description',
        'author': 'Author Name',
        'authorLink': 'Author Link',
        'view': 'Story View',
        'detail': 'Story Detail',
        'categoryList': [
          {
            'content': 'Category 1',
            'href' : 'href1',
            // Add category properties here
          },
          {
            'content': 'Category 2',
            'href' : 'href2',
            // Add category properties here
          },
        ],
      };

      final story = Story.fromJson(json);

      expect(story.name, 'Story Name');
      expect(story.cover, 'Cover URL');
      expect(story.link, 'Link URL');
      expect(story.title, 'Story Title');
      expect(story.description, 'Story Description');
      expect(story.author, 'Author Name');
      expect(story.authorLink, 'Author Link');
      expect(story.view, 'Story View');
      expect(story.detail, 'Story Detail');
      expect(story.categories!.length, 2);
      expect(story.categories![0].content, 'Category 1');
      expect(story.categories![1].content, 'Category 2');
      // Add more assertions for category properties
    });

    test('toString should return the correct string representation', () {
      final story = Story(
        name: 'Story Name',
        cover: 'Cover URL',
        link: 'Link URL',
        title: 'Story Title',
        description: 'Story Description',
        author: 'Author Name',
        authorLink: 'Author Link',
        view: 'Story View',
        detail: 'Story Detail',
        categories: [
          Category(content: 'Category 1', url: 'href1'),
          Category(content: 'Category 2', url: 'href2'),
        ],
      );

      final result = story.toString();

      expect(result, 'Story{name: Story Name,detail: Story Detail,cover: Cover URL, categories: Category{content: Category 1, url: href1} === Category{content: Category 2, url: href2}}');
      // Add more assertions for the string representation
    });
  });
}