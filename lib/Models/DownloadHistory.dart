class DownloadHistory {
  String title;
  int date;
  String cover;
  String dataSource;
  String link;

  DownloadHistory(
      {required this.title,
      required this.date,
      required this.cover,
      required this.dataSource,
      required this.link});

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'date': date,
      'cover': cover,
      'dataSource': dataSource,
      'link': link,
    };
  }
}
