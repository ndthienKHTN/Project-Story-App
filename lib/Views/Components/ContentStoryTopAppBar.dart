import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModels/ContentStoryViewModel.dart';

class ContentStoryTopAppBar extends StatefulWidget{
  final ContentStoryViewModel _contentStoryViewModel;

  const ContentStoryTopAppBar(this._contentStoryViewModel, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ContentStoryTopAppBarState();
  }
}

class _ContentStoryTopAppBarState extends State<ContentStoryTopAppBar>{
  ContentStoryViewModel get contentStoryViewModel =>
      widget._contentStoryViewModel;

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
      actions: [
        IconButton(
          icon: Image.asset('assets/images/download_icon.png'),
          onPressed: () {
            // Xử lý khi nhấn vào icon bên phải
          },
        ),
      ],
      title: Text(
        contentStoryViewModel.contentStory?.title ?? 'title',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}