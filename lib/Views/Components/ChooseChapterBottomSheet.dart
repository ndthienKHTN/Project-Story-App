import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseChapterBottomSheet extends StatelessWidget {
  const ChooseChapterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final List<String> items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
      'Item 6',
      'Item 7',
      'Item 8',
      'Item 9',
      'Item 10',
      'Item 11',
      'Item 12',
      'Item 13',
      'Item 14',
      'Item 15',
      'Item 16'
    ];

    return Container(
      width: double.infinity,
      height: screenHeight / 2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text(
                "${items.length} chương",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  items[index],
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  print('Chap ${index + 1} được nhấn.');
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
