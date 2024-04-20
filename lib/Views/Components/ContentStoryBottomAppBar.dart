import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/ContentStoryViewModel.dart';
import 'package:project_login/Views/Components/ChangeDisplayBottomSheet.dart';
import 'package:project_login/Views/Components/ChooseChapterBottomSheet.dart';

class ContentStoryBottomAppBar extends StatelessWidget {
  final ContentStoryViewModel _contentStoryViewModel;
  final Function(double) onTextSizeChanged;
  final Function(double) onLineSpacingChanged;

  const ContentStoryBottomAppBar(this._contentStoryViewModel, this.onTextSizeChanged,
      this.onLineSpacingChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/back_button.png')),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/list_icon.png')), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/next_button.png')),
                label: '')
          ],
          onTap: (int index) {
            if (index == 0) {
              print("index 0");
            } else if (index == 1) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => const ChooseChapterBottomSheet(),
              );
            } else if (index == 2) {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) => ChangeDisplayBottomSheet(_contentStoryViewModel, onTextSizeChanged, onLineSpacingChanged),
              );
            } else if (index == 3) {
              print("index 3");
            }
          },
        ));
  }
}
