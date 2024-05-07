import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_login/Constants.dart';
import '../../ViewModels/ContentStoryViewModel.dart';
import '../Components/ContentStoryBottomAppBar.dart';
import '../Components/ContentStoryTopAppBar.dart';


class ContentStoryScreen extends StatefulWidget {
  final String storyTitle;
  final String datasource;
  static const double MIN_TEXT_SIZE = 5;
  static const double MAX_TEXT_SIZE = 30;
  static const double MIN_LINE_SPACING = 0.5;
  static const double MAX_LINE_SPACING = 5;

  const ContentStoryScreen({super.key, required this.storyTitle, required this.datasource});

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
    _contentStoryViewModel.fetchContentStory(widget.storyTitle,1,widget.datasource);
    _contentStoryViewModel.fetchContentDisplay();
    _contentStoryViewModel.fetchChapterPagination(widget.storyTitle, 1, widget.datasource);
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
                      color: intToColor(contentStoryViewModel
                          .contentDisplay.backgroundColor),
                    ),
                    child: contentStoryViewModel.contentStory !=
                        null // sửa lại != null khi load được data
                        ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          contentStoryViewModel.contentStory?.content ?? 'content', // load data
                          //'contffffffffffffffffffffffffffffffffffffffffent\ncontent',
                          // fake data
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
            bottomNavigationBar: ContentStoryBottomAppBar(
                contentStoryViewModel,
                onTextSizeChanged,
                onLineSpacingChanged,
                onFontFamilyChanged,
                onTextColorChanged,
                onBackgroundChanged));
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
}