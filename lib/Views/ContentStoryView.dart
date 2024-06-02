import 'package:flutter/material.dart';
import 'package:project_login/Constants.dart';
import 'package:project_login/Views/Components/ContentStoryTopAppBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ViewModels/ContentStoryViewModel.dart';
import 'Components/ContentStoryBottomAppBar.dart';

class ContentStoryScreen extends StatefulWidget {
  final String storyTitle;
  final int chap;
  final String dataSource;
  final int pageNumber;

  const ContentStoryScreen(
      {super.key,
      required this.storyTitle,
      required this.chap,
      required this.dataSource,
      required this.pageNumber});

  @override
  State<StatefulWidget> createState() => _ContentStoryScreenState();
}

class _ContentStoryScreenState extends State<ContentStoryScreen> {
  late ContentStoryViewModel _contentStoryViewModel;
  bool isLoadingSuccess = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _contentStoryViewModel =
        Provider.of<ContentStoryViewModel>(context, listen: false);
    _fetchData();
    // scroll to top when change chapter
    _contentStoryViewModel.addListener(_scrollToTop);
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _fetchData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _contentStoryViewModel.setPreferences(sharedPreferences);

    await Future.wait([
      _contentStoryViewModel.fetchChapterPagination(
          widget.storyTitle, widget.pageNumber, widget.dataSource, true),
      _contentStoryViewModel.fetchSourceBooks()
    ]);

    isLoadingSuccess = await _contentStoryViewModel.fetchContentStory(
        widget.storyTitle, widget.chap, widget.dataSource, widget.dataSource);

    if (!isLoadingSuccess){
      showMyDialog(_contentStoryViewModel.currentSource);
    }

    await Future.wait([
      _contentStoryViewModel.fetchContentDisplay(),
      _contentStoryViewModel.fetchFormatList(),
    ]);
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    _contentStoryViewModel.removeListener(_scrollToTop);
    _scrollController.dispose();
    super.dispose();
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
                    controller: _scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              contentStoryViewModel.contentStory?.content ??
                                  'content',
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
      if (_contentStoryViewModel.currentChapNumber %
              _contentStoryViewModel.chapterPagination.chapterPerPage ==
          0) {
        _contentStoryViewModel.fetchChapterPagination(
            widget.storyTitle,
            ++_contentStoryViewModel.currentPageNumber,
            _contentStoryViewModel.currentSource,
            true);
      }
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle,
          ++_contentStoryViewModel.currentChapNumber,
          _contentStoryViewModel.currentSource,
          _contentStoryViewModel.currentSource);
    });
  }

  void navigateToPrevChap() {
    setState(() {
      if (_contentStoryViewModel.currentChapNumber %
              _contentStoryViewModel.chapterPagination.chapterPerPage ==
          1) {
        _contentStoryViewModel.fetchChapterPagination(
            widget.storyTitle,
            --_contentStoryViewModel.currentPageNumber,
            _contentStoryViewModel.currentSource,
            true);
      }
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle,
          --_contentStoryViewModel.currentChapNumber,
          _contentStoryViewModel.currentSource,
          _contentStoryViewModel.currentSource);
    });
  }

  void navigateToNewChap(int index, int pageNumber) {
    _contentStoryViewModel.currentPageNumber = pageNumber;
    _contentStoryViewModel.currentChapNumber = (pageNumber - 1) *
            _contentStoryViewModel.chapterPagination.chapterPerPage +
        index +
        1;
    print(_contentStoryViewModel.currentChapNumber.toString());
    setState(() {
      _contentStoryViewModel.fetchContentStory(
          widget.storyTitle,
          _contentStoryViewModel.currentChapNumber,
          _contentStoryViewModel.currentSource,
          _contentStoryViewModel.currentSource);
    });
  }

  void onSourceChange(String newSource) async {
    bool result = await _contentStoryViewModel.fetchContentStory(
        widget.storyTitle,
        _contentStoryViewModel.currentChapNumber,
        newSource,
        newSource);

    // if we cannot load content from newSource (result == false), show dialog
    if (!result) {
      showMyDialog(newSource);
    }
  }

  void showMyDialog(String newSource){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tải thất bại'),
          content: Text(
              'Không thể tải truyện từ $newSource. Tải truyện từ ${_contentStoryViewModel.currentSource} để thay thế'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
