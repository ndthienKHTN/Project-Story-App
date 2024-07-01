class ReadingHistory {
  String name;
  String title;
  int chap;
  int date;
  String author;
  String cover;
  String dataSource;
  int pageNumber;

  ReadingHistory(
      {required this.name,
      required this.title,
      required this.chap,
      required this.date,
      required this.author,
      required this.cover,
      required this.pageNumber,
      required this.dataSource});

  Map<String, Object?> toMap() {
    return {
      'pageNumber': pageNumber,
      'name': name,
      'title': title,
      'chap': chap,
      'date': date,
      'author': author,
      'cover': cover,
      'dataSource': dataSource,
    };
  }
}
