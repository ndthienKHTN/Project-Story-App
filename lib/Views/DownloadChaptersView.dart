import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../ViewModels/DetailStoryViewModel.dart';
class DownloadChaptersScreen extends StatefulWidget {
  final String storyTitle;
  final String datasource;
  const DownloadChaptersScreen({super.key, required this.storyTitle,required this.datasource});

  @override
  _DownloadChaptersState createState() => _DownloadChaptersState();
}

class _DownloadChaptersState extends State<DownloadChaptersScreen>{
  late DetailStoryViewModel _detailStoryViewModel;
  final int buttonsPerRow = 3;
  int _perPage = 27;
  int _currentPage = 1;
  late Map<int, bool> selectedButtons;
  bool _isCheckAll = false;
  void _fetchChapters() {
    _detailStoryViewModel.fetchChapterPagination(widget.storyTitle, _currentPage, widget.datasource);
  }
  @override
  void initState() {
    super.initState();
    _detailStoryViewModel = Provider.of<DetailStoryViewModel>(context, listen: false);
    _fetchChapters();
    selectedButtons = Map.fromIterable(
      List.generate(_perPage, (index) => index + 1),
      key: (item) => item,
      value: (item) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title:Padding(
          padding: EdgeInsets.only(top: 6),
          child: Center(
            child: Text("Chọn chương để tải về",style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
          ),
        ) ,
      ),
      body: Consumer<DetailStoryViewModel>(
        builder: (context, storyDetailViewModel,_) {
          final chapter = storyDetailViewModel.chapterPagination!;
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/background_home.png',
                      ),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Tổng số chương: ${chapter.maxChapter}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50.0,
                left: 20.0,
                right: 20.0,
                bottom: 50,
                child: GridView.builder(
                    itemCount: _currentPage * _perPage >= chapter.maxChapter ? chapter.maxChapter - (_currentPage-1) * _perPage : _perPage,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: buttonsPerRow,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 100 / 40,
                    ),
                    itemBuilder: (BuildContext,int index){
                      return ElevatedButton(
                        onPressed: (){
                          setState(() {
                            selectedButtons[index+1] = !selectedButtons[index+1]!;
                          });
                        },
                        child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            '${_perPage*(_currentPage-1) + index+1}'
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedButtons[index+1]! ? Colors.yellow : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                        ),
                      );
                    }
                ),
              ),
              Positioned(
                left: 13,
                bottom: 10,
                right: 20,
                top: 540,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: _currentPage == 1 ? Colors.grey : Colors.white,),
                      onPressed: _currentPage == 1
                          ? null
                          : () {
                        setState(() {
                          _currentPage--;
                        });
                      },
                    ),
                    Text(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        'Page $_currentPage'
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: _currentPage * _perPage >= chapter.maxChapter ? Colors.grey : Colors.white,),
                      onPressed: _currentPage * _perPage >= chapter.maxChapter
                          ? null
                          : () {
                        setState(() {
                          _currentPage++;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomAppBar(
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: _isCheckAll,
                            onChanged: (bool ?value){
                              setState(() {
                                _isCheckAll = value!;
                                if(_isCheckAll){
                                  selectedButtons = Map.fromIterable(
                                    List.generate(_perPage, (index) => index + 1),
                                    key: (item) => item,
                                    value: (item) => true,
                                  );
                                }
                                else{
                                  selectedButtons = Map.fromIterable(
                                    List.generate(_perPage, (index) => index + 1),
                                    key: (item) => item,
                                    value: (item) => false,
                                  );
                                }
                              });
                            }
                        ),
                        Text(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            'Chọn tất cả'
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        VerticalDivider(
                          color: Colors.black ,
                          thickness: 2,
                          width: 20,
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                            onPressed: (){
                              _showDialogWithDropdown(context);
                            },
                            icon: Icon(Icons.download)
                        ),
                        TextButton(
                            onPressed: () {
                                _showDialogWithDropdown(context);
                                },
                            child: Text(
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                              'Tải xuống'
                            )
                        ),
                      ],
                    ),
                  )
              )
            ],
          );
        }
      )
    );
  }
}
void _showDialogWithDropdown(BuildContext context) {
  String? selectedValue;
  List<String> dropdownItems = ['pdf', 'prc', 'epub'];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select an Option'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<String>(
              value: selectedValue,
              hint: Text('Choose an option'),
              items: dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue;
                });
              },
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // Handle the selected value here
              print('Selected value: $selectedValue');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
