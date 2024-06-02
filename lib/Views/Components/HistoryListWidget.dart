import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/ReadingHistoryViewModel.dart';
import 'package:project_login/Views/Components/ReadingHistoryItem.dart';
import 'package:provider/provider.dart';

import '../../Models/ReadingHistory.dart';
import '../../ViewModels/ContentStoryViewModel.dart';
import '../ContentStoryView.dart';

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  late ReadingHistoryViewModel _readingHistoryViewModel;

  @override
  void initState() {
    super.initState();
    _readingHistoryViewModel =
        Provider.of<ReadingHistoryViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _readingHistoryViewModel.fetchReadingHistoryList();

    return Consumer<ReadingHistoryViewModel>(
        builder: (context, readingHistoryViewModel, _) {
      return Expanded(
        child: ListView.builder(
          itemCount: readingHistoryViewModel.readingHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ReadingHistoryItem(
                  readingHistoryViewModel.readingHistoryList[index],
                  onClickItem),
            );
          },
        ),
      );
    });
  }

  void onClickItem(ReadingHistory readingHistory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context) => ContentStoryViewModel(),
            child: ContentStoryScreen(
              storyTitle: readingHistory.title,
              chap: readingHistory.chap,
              dataSource: readingHistory.dataSource,
              pageNumber: readingHistory.pageNumber,
            )),
      ),
    );
  }
}
