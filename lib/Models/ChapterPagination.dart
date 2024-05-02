import 'Chapter.dart';

class ChapterPagination {
  List<Chapter>? listChapter;
  int maxChapter;
  int currentPage;
  int maxPage;

  ChapterPagination({required this.listChapter,
                    required this.maxChapter,
                    required this.currentPage,
                    required this.maxPage});

  factory ChapterPagination.fromJson(Map<String, dynamic> json) {
    List<Chapter>? listChapterFromApi = json['listChapter'] != null
        ? (json['listChapter'] as List<dynamic>).map(
            (chapter) => Chapter.fromJson(chapter)
    ).toList()
        : null;

    return ChapterPagination(listChapter: listChapterFromApi,
                              maxChapter: json['maxChapter'],
                              currentPage: json['currentPage'],
                              maxPage: json['maxPage']);
  }

  @override
  String toString() {
    String? str = listChapter?.join(" === ");
    return 'ChapterPagination{listChapter: $str, maxChapter: $maxChapter, currentPage: $currentPage, maxPage: $maxPage}';
  }
}