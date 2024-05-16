import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ViewModels/ContentStoryViewModel.dart';

class DownloadSingleChapterDialog extends StatefulWidget {
  final ContentStoryViewModel _contentStoryViewModel;

  const DownloadSingleChapterDialog(this._contentStoryViewModel, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _DownloadSingleChapterDialogState();
  }
}

class _DownloadSingleChapterDialogState extends State<DownloadSingleChapterDialog> {
  ContentStoryViewModel get contentStoryViewModel => widget._contentStoryViewModel;

  String? selectedFormat;

  @override
  void initState() {
    super.initState();
    selectedFormat = contentStoryViewModel.formatList[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Định dạng')),
      content: SingleChildScrollView(
        child: Column(
          children: contentStoryViewModel.formatList
              .map((String format) => RadioListTile<String>(
                    title: Text(format),
                    value: format,
                    groupValue: selectedFormat,
                    onChanged: (String? value) {
                      setState(() {
                        selectedFormat = value;
                      });
                    },
                  ))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            print('Choose ${selectedFormat}');
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
