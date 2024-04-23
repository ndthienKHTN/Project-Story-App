import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModels/ContentStoryViewModel.dart';


class ContentStoryScreen extends StatefulWidget {
  final String storyTitle;

  const ContentStoryScreen({required this.storyTitle});

  @override
  _ContentStoryScreenState createState() => _ContentStoryScreenState();
}

class _ContentStoryScreenState extends State<ContentStoryScreen> {
  late ContentStoryViewModel _contentStoryViewModel;

  @override
  void initState() {
    super.initState();
    _contentStoryViewModel = Provider.of<ContentStoryViewModel>(context, listen: false);
    _contentStoryViewModel.fetchContentStory(widget.storyTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Content'),
      ),
      body: Consumer<ContentStoryViewModel>(
        builder: (context, storyContentViewModel, _) {
          if (storyContentViewModel.contentStory == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            final storyContent = storyContentViewModel.contentStory!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(storyContent.content),
              ),
            );
          }
        },
      ),
    );
  }
}