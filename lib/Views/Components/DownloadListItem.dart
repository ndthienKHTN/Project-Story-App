import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_login/Models/DownloadHistory.dart';
import 'package:project_login/ViewModels/DownloadChaptersViewModel.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

import '../../Models/ReadingHistory.dart';

class DownloadListItem extends StatelessWidget{
  final DownloadChaptersViewModel _downloadChaptersViewModel = DownloadChaptersViewModel();
  final DownloadHistory downloadHistory;
  final Function(DownloadHistory) onClick;

  DownloadListItem(this.downloadHistory, this.onClick, {super.key});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick(downloadHistory);
      },
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.yellow,
                  width: 2.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(downloadHistory.cover,errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/default_image.png',
                    height: 101,
                    width: 84,
                  );
                },),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  downloadHistory.name,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Tập: " + downloadHistory.chap.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
                Text(
                  downloadHistory.dataSource,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}