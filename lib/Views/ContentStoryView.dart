import 'package:flutter/material.dart';
import 'package:project_login/Constants.dart';
import 'package:project_login/Views/Components/ContentStoryTopAppBar.dart';
import 'package:provider/provider.dart';

import '../ViewModels/ContentStoryViewModel.dart';
import 'Components/ContentStoryBottomAppBar.dart';

class ContentStoryScreen extends StatefulWidget {
  final String storyTitle;
  final String title;

  //TODO: này phải chương số mấy không
  final int chap;

  final String dataSource;
  final int pageNumber;

  static const double MIN_TEXT_SIZE = 5;
  static const double MAX_TEXT_SIZE = 30;
  static const double MIN_LINE_SPACING = 0.5;
  static const double MAX_LINE_SPACING = 5;

  const ContentStoryScreen(
      {super.key,
      required this.storyTitle,
        required this.title,
      required this.chap,
      required this.dataSource,
      required this.pageNumber});

  @override
  State<StatefulWidget> createState() => _ContentStoryScreenState();
}

class _ContentStoryScreenState extends State<ContentStoryScreen> {
  late ContentStoryViewModel _contentStoryViewModel;

  @override
  void initState() {
    super.initState();
    _contentStoryViewModel =
        Provider.of<ContentStoryViewModel>(context, listen: false);
    _fetchData();
  }

  void _fetchData() async {
    await _contentStoryViewModel.fetchChapterPagination(
        widget.storyTitle, widget.pageNumber,widget.dataSource,  true);
    await Future.wait([
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle, widget.chap,  widget.dataSource),
      _contentStoryViewModel.fetchContentDisplay(),
      _contentStoryViewModel.fetchSourceBooks(),
      _contentStoryViewModel.fetchFormatList(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentStoryViewModel>(
      builder: (context, contentStoryViewModel, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ContentStoryTopAppBar(contentStoryViewModel)),
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background_home.png'),
                      fit: BoxFit.fill)),
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    color: intToColor(
                        contentStoryViewModel.contentDisplay.backgroundColor),
                  ),
                  child: contentStoryViewModel.contentStory != null
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              contentStoryViewModel.contentStory?.content ?? 'content',
                              style: TextStyle(
                                  fontSize: contentStoryViewModel
                                      .contentDisplay.textSize,
                                  height: contentStoryViewModel
                                      .contentDisplay.lineSpacing,
                                  fontFamily: contentStoryViewModel
                                      .contentDisplay.fontFamily,
                                  color: intToColor(contentStoryViewModel
                                      .contentDisplay.textColor)),
                            ), // dữ liệu giả
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              )),
          bottomNavigationBar: contentStoryViewModel.contentStory != null
              ? ContentStoryBottomAppBar(
                  contentStoryViewModel: contentStoryViewModel,
                  onTextSizeChanged: (newSize) {
                    onTextSizeChanged(newSize);
                  },
                  onLineSpacingChanged: (newSize) {
                    onLineSpacingChanged(newSize);
                  },
                  onFontFamilyChanged: (newFont) {
                    onFontFamilyChanged(newFont);
                  },
                  onTextColorChanged: (newColor) {
                    onTextColorChanged(newColor);
                  },
                  onBackgroundChanged: (newColor) {
                    onBackgroundChanged(newColor);
                  },
                  onChooseChapter: (index, pageNumber) {
                    navigateToNewChap(index, pageNumber);
                  },
                  navigateToNextChap: () {
                    navigateToNextChap();
                  },
                  navigateToPrevChap: () {
                    navigateToPrevChap();
                  },
                  onSourceChange: (source) {
                    onSourceChange(source);
                  },
                )
              : null,
        );
      },
    );
  }

  // change text size
  void onTextSizeChanged(double newSize) {
    setState(() {
      _contentStoryViewModel.contentDisplay.textSize = newSize;
    });
    _contentStoryViewModel.saveDouble(TEXT_SIZE_KEY, newSize);
  }

  // change line spacing
  void onLineSpacingChanged(double newSize) {
    setState(() {
      _contentStoryViewModel.contentDisplay.lineSpacing = newSize;
    });
    _contentStoryViewModel.saveDouble(LINE_SPACING_KEY, newSize);
  }

  void onFontFamilyChanged(String fontFamily) {
    setState(() {
      _contentStoryViewModel.contentDisplay.fontFamily = fontFamily;
    });
    _contentStoryViewModel.saveString(FONT_FAMILY_KEY, fontFamily);
  }

  void onTextColorChanged(int textColor) {
    setState(() {
      _contentStoryViewModel.contentDisplay.textColor = textColor;
    });
    _contentStoryViewModel.saveInt(TEXT_COLOR_KEY, textColor);
  }

  void onBackgroundChanged(int backgroundColor) {
    setState(() {
      _contentStoryViewModel.contentDisplay.backgroundColor = backgroundColor;
    });
    _contentStoryViewModel.saveInt(BACKGROUND_COLOR_KEY, backgroundColor);
  }

  Color intToColor(int colorValue) {
    return Color(colorValue);
  }

  void navigateToNextChap() {
    setState(() {
      if (_contentStoryViewModel.chapterPagination.listChapter?.last.content ==
          _contentStoryViewModel.contentStory?.chapterTitle) {
        _contentStoryViewModel
            .fetchChapterPagination(
                widget.storyTitle,
                ++_contentStoryViewModel.currentPageNumber,
                _contentStoryViewModel.currentSource,
                true)
            .then((_) => _contentStoryViewModel.fetchContentStory(
                widget.storyTitle,
                //TODO: need to change
                1,
                /*_contentStoryViewModel
                    .chapterPagination.listChapter![0].content,*/
                _contentStoryViewModel.currentSource));
      } else {
        _contentStoryViewModel.fetchContentStory(

            widget.storyTitle,
            //TODO: need to change
            1,
            /*_contentStoryViewModel.chapterPagination
                .listChapter![++_contentStoryViewModel.indexChapter].content,*/
            _contentStoryViewModel.currentSource);
      }
    });
  }

  void navigateToPrevChap() {
    setState(() {
      if (_contentStoryViewModel.chapterPagination.listChapter?[0].content ==
          _contentStoryViewModel.contentStory?.chapterTitle) {
        _contentStoryViewModel
            .fetchChapterPagination(
                widget.storyTitle,
                --_contentStoryViewModel.currentPageNumber,
                _contentStoryViewModel.currentSource,
                true)
            .then((value) => _contentStoryViewModel.fetchContentStory(
                widget.storyTitle,
                //TODO: need to change
                1,
                /*_contentStoryViewModel
                    .chapterPagination.listChapter![50].content,*/
                _contentStoryViewModel.currentSource,));
      } else {
        _contentStoryViewModel.fetchContentStory(

            widget.storyTitle,
          //TODO: need to change
          1,
            /*_contentStoryViewModel.chapterPagination
                .listChapter![--_contentStoryViewModel.indexChapter].content*/
          _contentStoryViewModel.currentSource);
      }
    });
  }

  void navigateToNewChap(int index, int pageNumber) {
    _contentStoryViewModel.currentPageNumber = pageNumber;
    setState(() {
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle,
          //TODO: need to change
          1,
          /*_contentStoryViewModel.chapterPagination.listChapter![index].content*/
          _contentStoryViewModel.currentSource);
    });
  }

  void onSourceChange(String newSource) {
    setState(() {
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle, widget.chap, newSource);
    });
  }
}
