import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../ViewModels/ContentStoryViewModel.dart';

class ChooseChapterBottomSheet extends StatelessWidget {
  final ContentStoryViewModel _contentStoryViewModel;
  final Function(int) onChooseChapter;

  const ChooseChapterBottomSheet(
      this._contentStoryViewModel, this.onChooseChapter,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    ScrollController _scrollController = ScrollController();

    // jump to current chapter in list view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_contentStoryViewModel.index * CHAPTER_ITEM_HEIGHT);
    });

    return Container(
      width: double.infinity,
      height: screenHeight / 2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 20, right: 20),
              child: Text(
                "${_contentStoryViewModel.fakedatas.length} chương",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: ListView.builder(
            controller: _scrollController,
            itemCount: _contentStoryViewModel.fakedatas.length,
            itemExtent: CHAPTER_ITEM_HEIGHT,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  "Chương ${_contentStoryViewModel.fakedatas[index]}",
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  //print('Chap ${index + 1} được nhấn.');
                  onChooseChapter(index);
                  Navigator.of(context).pop();
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
