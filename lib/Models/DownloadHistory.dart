class DownloadHistory {
  String title;
  int date;
  String cover;
  String dataSource;

  DownloadHistory(
      {
        required this.title,
        required this.date,
        required this.cover,
        required this.dataSource});

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'date': date,
      'cover': cover,
      'dataSource': dataSource,
    };
  }
}
