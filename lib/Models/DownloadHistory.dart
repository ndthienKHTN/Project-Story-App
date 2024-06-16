class DownloadHistory {
  String title;
  String name;
  int date;
  int chap;
  String cover;
  String dataSource;
  String link;
  DownloadHistory(
      {required this.title,
        required this.name,
      required this.date,
        required this.chap,
      required this.cover,
      required this.dataSource,
      required this.link});

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'name' : name,
      'date': date,
      'chap': chap,
      'cover': cover,
      'dataSource': dataSource,
      'link': link,
    };
  }
}
