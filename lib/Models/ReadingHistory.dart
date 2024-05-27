class ReadingHistory {
  String title;
  String chap;
  int date;
  String author ='author';
  String cover = '12345';

  ReadingHistory({required this.title, required this.chap, required this.date});

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'chap': chap,
      'date': date,
    };
  }
}