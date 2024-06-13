import 'package:flutter/material.dart';
import 'package:project_login/Models/DownloadHistory.dart';
import 'package:project_login/ViewModels/DownloadHistoryViewModel.dart';
import 'package:project_login/ViewModels/ReadingHistoryViewModel.dart';
import 'package:project_login/Views/Components/DownloadListItem.dart';
import 'package:project_login/Views/Components/ReadingHistoryItem.dart';
import 'package:provider/provider.dart';

import '../../Models/ReadingHistory.dart';
import '../../ViewModels/ContentStoryViewModel.dart';
import '../ContentStoryView.dart';

class DownloadListWidget extends StatefulWidget {
  const DownloadListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<DownloadListWidget> {
  late DownloadHistoryViewModel _downloadHistoryViewModel;

  @override
  void initState() {
    super.initState();
    _downloadHistoryViewModel =
        Provider.of<DownloadHistoryViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _downloadHistoryViewModel.fetchDownloadList();

    return Consumer<DownloadHistoryViewModel>(
        builder: (context, downloadHistoryViewModel, _) {
          return Expanded(
            child: ListView.builder(
              itemCount: downloadHistoryViewModel.downloadHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DownloadListItem(
                      downloadHistoryViewModel.downloadHistoryList[index],
                      onClickItem),
                );
              },
            ),
          );
        });
  }

  void onClickItem(DownloadHistory downloadHistory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context) => ContentStoryViewModel(),
            child: ContentStoryScreen(
              storyTitle: downloadHistory.title,
              chap: 1,
              dataSource: downloadHistory.dataSource,
              pageNumber: 1,
              name: "Nguyen Duc Thien",
            )),
      ),
    );
  }
}
