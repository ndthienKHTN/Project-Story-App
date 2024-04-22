import 'package:flutter/material.dart';
import 'package:project_login/Views/Components/ContentStoryTopAppBar.dart';
import 'package:provider/provider.dart';

import '../ViewModels/ContentStoryViewModel.dart';
import 'Components/ContentStoryBottomAppBar.dart';

class ContentStoryScreen extends StatefulWidget {
  final String storyTitle;
  static const double MIN_TEXT_SIZE = 5;
  static const double MAX_TEXT_SIZE = 30;
  static const double MIN_LINE_SPACING = 0.5;
  static const double MAX_LINE_SPACING = 5;

  const ContentStoryScreen({super.key, required this.storyTitle});

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
    _contentStoryViewModel.fetchContentStory(widget.storyTitle);
    _contentStoryViewModel.fetchContentDisplay(widget.storyTitle);
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: Colors.white,
                    ),
                    child: contentStoryViewModel.contentStory !=
                            null // sửa lại != null khi load được data
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                contentStoryViewModel.contentStory?.content ?? 'content', // load data
                                //'contffffffffffffffffffffffffffffffffffffffffent\ncontent', // fake data
                                style: TextStyle(
                                  fontSize: contentStoryViewModel.contentDisplay.textSize,
                                  height: contentStoryViewModel.contentDisplay.lineSpacing,
                                ),
                              ), // dữ liệu giả
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                )),
            bottomNavigationBar: ContentStoryBottomAppBar(
                _contentStoryViewModel,
                onTextSizeChanged,
                onLineSpacingChanged));
      },
    );
  }

  // change text size
  void onTextSizeChanged(double newSize) {
    setState(() {
      _contentStoryViewModel.contentDisplay.textSize = newSize;
    });
  }

  // change line spacing
  void onLineSpacingChanged(double newSize) {
    setState(() {
      _contentStoryViewModel.contentDisplay.lineSpacing = newSize;
    });
  }
}
