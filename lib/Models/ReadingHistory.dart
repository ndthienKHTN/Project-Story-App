class ReadingHistory {
  String title;
  String chap;
  int date;

  ReadingHistory({required this.title, required this.chap, required this.date});

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'chap': chap,
      'date': date,
    };
  }
}