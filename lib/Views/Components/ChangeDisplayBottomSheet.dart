import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_login/Views/ContentStoryView.dart';

import '../../Constants.dart';
import '../../ViewModels/ContentStoryViewModel.dart';

class ChangeDisplayBottomSheet extends StatefulWidget {
  final ContentStoryViewModel _contentStoryViewModel;
  final Function(double) onTextSizeChanged;
  final Function(double) onLineSpacingChanged;
  final Function(String) onFontFamilyChanged;
  final Function(int) onTextColorChanged;
  final Function(int) onBackgroundChanged;

  const ChangeDisplayBottomSheet(
      this._contentStoryViewModel,
      this.onTextSizeChanged,
      this.onLineSpacingChanged,
      this.onFontFamilyChanged,
      this.onTextColorChanged,
      this.onBackgroundChanged,
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
    dropdownValue = contentStoryViewModel.contentDisplay.fontFamily;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const int textSizeChange = 2;
    const double lineSpacingChange = 0.5;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
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
                            MIN_TEXT_SIZE) {
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ImageIcon(
                          AssetImage('assets/text_size_decrease_icon.png')),
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
                            MAX_TEXT_SIZE) {
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
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ImageIcon(
                          AssetImage('assets/text_size_increase_icon.png')),
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
                        if (contentStoryViewModel.contentDisplay.lineSpacing -
                            lineSpacingChange >=
                            MIN_LINE_SPACING) {
                          double newlineSpacing =
                              contentStoryViewModel.contentDisplay.lineSpacing -
                                  lineSpacingChange;
                          contentStoryViewModel.contentDisplay.lineSpacing =
                              newlineSpacing;
                          widget.onLineSpacingChanged(newlineSpacing);
                        }
                      });
                    },
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ImageIcon(
                          AssetImage('assets/line_spacing_decrease_icon.png')),
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
                        if (contentStoryViewModel.contentDisplay.lineSpacing + lineSpacingChange <= MAX_LINE_SPACING) {
                          double newlineSpacing = contentStoryViewModel.contentDisplay.lineSpacing + lineSpacingChange;
                          contentStoryViewModel.contentDisplay.lineSpacing = newlineSpacing;
                          widget.onLineSpacingChanged(newlineSpacing);
                        }
                      });
                    },
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: ImageIcon(
                          AssetImage('assets/line_spacing_increase_icon.png')),
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
                    widget.onFontFamilyChanged(dropdownValue);
                  });
                },
                items: contentStoryViewModel.fontNames
                    .map<DropdownMenuItem<String>>((String value) {
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        "Màu chữ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            _showColorPickerDialog(widget.onTextColorChanged);
                          },
                          child: Text('Chọn'),
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        "Màu nền",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            _showColorPickerDialog(widget.onBackgroundChanged);
                          },
                          child: Text('Chọn'),
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPickerDialog(Function(int) onConfirmClicked) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chọn màu'),
          content: SingleChildScrollView(
            child: MaterialColorPicker(
              onColorChange: (Color color) {
                onConfirmClicked(color.value);
              },
              // selectedColor: _selectedColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
