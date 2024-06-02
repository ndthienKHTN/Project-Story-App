import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/ReadingHistory.dart';

class ReadingHistoryItem extends StatelessWidget{
  final ReadingHistory readingHistory;
  final Function(ReadingHistory) onClick;

  const ReadingHistoryItem(this.readingHistory, this.onClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick(readingHistory);
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
                borderRadius: BorderRadius.circular(15),
                child: Image.network(readingHistory.cover),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  readingHistory.name,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "By: ${readingHistory.author}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Đã đọc đến chương: ${readingHistory.chap}",
                  style: TextStyle(
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