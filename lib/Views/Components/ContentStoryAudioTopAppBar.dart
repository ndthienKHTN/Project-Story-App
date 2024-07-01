import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/ContentStoryAudioViewModel.dart';

class ContentStoryAudioTopAppBar extends StatefulWidget {
  final ContentStoryAudioViewModel  _contentStoryAudioViewModel;

  const ContentStoryAudioTopAppBar(this._contentStoryAudioViewModel, {super.key});

  @override
  _ContentStoryAudioTopAppBarState createState() {
    return _ContentStoryAudioTopAppBarState();
  }
}

class _ContentStoryAudioTopAppBarState extends State<ContentStoryAudioTopAppBar> {
  ContentStoryAudioViewModel get contentStoryAudioViewModel =>
      widget._contentStoryAudioViewModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/images/back_icon.png'), // Icon bên trái
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        contentStoryAudioViewModel.contentStory?.chapterTitle ?? 'chapterTitle',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
