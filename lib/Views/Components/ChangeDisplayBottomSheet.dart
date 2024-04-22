import 'package:flutter/material.dart';
import 'package:project_login/Views/ContentStoryView.dart';

import '../../ViewModels/ContentStoryViewModel.dart';

class ChangeDisplayBottomSheet extends StatefulWidget {
  final ContentStoryViewModel _contentStoryViewModel;
  final Function(double) onTextSizeChanged;
  final Function(double) onLineSpacingChanged;

  const ChangeDisplayBottomSheet(this._contentStoryViewModel,
      this.onTextSizeChanged, this.onLineSpacingChanged,
      {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangeDisplayBottomSheetState();
  }
}

class _ChangeDisplayBottomSheetState extends State<ChangeDisplayBottomSheet> {
  ContentStoryViewModel get contentStoryViewModel =>
      widget._contentStoryViewModel;

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = contentStoryViewModel.contentDisplay.fontLists[0];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const int textSizeChange = 2;
    const double lineSpacingChange = 0.5;

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
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
              child: Text(
                "Size",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(204),
                      topRight: Radius.circular(204),
                      bottomLeft: Radius.circular(204),
                      bottomRight: Radius.circular(204),
                    ),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (contentStoryViewModel.contentDisplay.textSize -
                              textSizeChange >=
                          ContentStoryScreen.MIN_TEXT_SIZE) {
                        double newTextSize =
                            contentStoryViewModel.contentDisplay.textSize -
                                textSizeChange;
                        contentStoryViewModel.contentDisplay.textSize =
                            newTextSize;
                        widget.onTextSizeChanged(newTextSize);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ImageIcon(
                        AssetImage('assets/images/text_size_decrease_icon.png')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  contentStoryViewModel.contentDisplay.textSize.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(204),
                      topRight: Radius.circular(204),
                      bottomLeft: Radius.circular(204),
                      bottomRight: Radius.circular(204),
                    ),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (contentStoryViewModel.contentDisplay.textSize +
                              textSizeChange <=
                          ContentStoryScreen.MAX_TEXT_SIZE) {
                        double newTextSize =
                            contentStoryViewModel.contentDisplay.textSize +
                                textSizeChange;
                        contentStoryViewModel.contentDisplay.textSize =
                            newTextSize;
                        widget.onTextSizeChanged(newTextSize);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ImageIcon(
                        AssetImage('assets/images/text_size_increase_icon.png')),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(204),
                      topRight: Radius.circular(204),
                      bottomLeft: Radius.circular(204),
                      bottomRight: Radius.circular(204),
                    ),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (contentStoryViewModel.contentDisplay.lineSpacing - lineSpacingChange >=
                          ContentStoryScreen.MIN_LINE_SPACING) {
                        double newlineSpacing = contentStoryViewModel.contentDisplay.lineSpacing - lineSpacingChange;
                        contentStoryViewModel.contentDisplay.lineSpacing = newlineSpacing;
                        widget.onLineSpacingChanged(newlineSpacing);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ImageIcon(
                        AssetImage('assets/images/line_spacing_decrease_icon.png')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  contentStoryViewModel.contentDisplay.lineSpacing.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(204),
                      topRight: Radius.circular(204),
                      bottomLeft: Radius.circular(204),
                      bottomRight: Radius.circular(204),
                    ),
                    color: Colors.white),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (contentStoryViewModel.contentDisplay.lineSpacing + lineSpacingChange <=
                          ContentStoryScreen.MAX_LINE_SPACING) {
                        double newlineSpacing = contentStoryViewModel.contentDisplay.lineSpacing + lineSpacingChange;
                        contentStoryViewModel.contentDisplay.lineSpacing = newlineSpacing;
                        widget.onLineSpacingChanged(newlineSpacing);
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ImageIcon(
                        AssetImage('assets/images/line_spacing_increase_icon.png')),
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Font",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.white),
            width: screenWidth - 50,
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: contentStoryViewModel.contentDisplay.fontLists.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              isExpanded: true,
              menuMaxHeight: screenHeight / 4,
              underline: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
