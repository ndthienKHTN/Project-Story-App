import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'package:project_login/Views/DownloadChaptersView.dart';
import 'package:provider/provider.dart';
import '../Models/Chapter.dart';
import '../Models/Story.dart';
import '../ViewModels/ContentStoryViewModel.dart';
import '../ViewModels/DetailStoryViewModel.dart';
import '../ViewModels/DownloadChaptersViewModel.dart';
import 'ContentStoryView.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';

class DetailStoryScreen extends StatefulWidget {
  String storyTitle;
  String datasource;
  DetailStoryScreen({super.key, required this.storyTitle,required this.datasource});

  @override
  _DetailStoryScreenState createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  late DetailStoryViewModel _detailStoryViewModel;
  int  _currentPage = 1;
  late int _perPage ; // Số lượng mục trên mỗi trang
  // Trang hiện tại
  bool _isBtnDescribePressed = false;
  bool _isBtnChapterPressed = false;
  String ? selectedItem ;
  late int selectedIndex;
  Widget ?_currentData ;
  List<String> items =[];
  void _fetchChapters() async{

    await _detailStoryViewModel.fetchChapterPagination(widget.storyTitle, _currentPage, widget.datasource);
    if(_detailStoryViewModel.chapterPagination?.chapterPerPage != null ){
      _perPage = _detailStoryViewModel.chapterPagination!.chapterPerPage;
    }
  }
  void _fetchDatasource(String source) async{
    await Future.wait([_detailStoryViewModel.fetchSourceBooks()]);
    items = _detailStoryViewModel.sourceBooks;
    int newIndex = items.indexOf(source);
    items.insert(0, items.removeAt(newIndex));
  }
  @override
  void initState() {
    super.initState();
    _detailStoryViewModel = Provider.of<DetailStoryViewModel>(context, listen: false);
    _detailStoryViewModel.fetchDetailsStory(widget.storyTitle, widget.datasource);
    String? changeSource = widget.datasource;
    //Chưa sử dụng
    _fetchChapters();
    _fetchDatasource(changeSource);


  }
  // void initDescription(String description){
  //   _currentData = SingleChildScrollView(
  //     child: Padding(
  //       padding: EdgeInsets.all(5),
  //       child: Text('${description}'),
  //     ),
  //   );
  // }
  void showMyDialog(String newSource){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tải thất bại'),
          content: Text(
              'Không thể tải truyện từ $newSource. Tải truyện từ ${_detailStoryViewModel.currentSource} để thay thế'),
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
  Future<bool> onSourceChange(String name,String newSource) async {
    await _detailStoryViewModel.fetchChangeDetailStoryToThisDataSource(name, newSource);
    if(_detailStoryViewModel.changedStory != null){
      widget.datasource = newSource;
      widget.storyTitle = _detailStoryViewModel.changedStory!.title;

      _currentPage = 1;
      //await _detailStoryViewModel.fetchChapterPagination(widget.storyTitle, _currentPage , newSource);
      _fetchChapters();
      _fetchDatasource(newSource);
      return true;
    }
    else {
      showMyDialog(newSource);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            color: Colors.white,
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                  create: (_) => DetailStoryViewModel(),
                  child: DownloadChaptersScreen(storyTitle: widget.storyTitle, datasource: widget.datasource)
                )),
              );
            },
            icon: SizedBox(
                width: 35,
                height: 35,
                child: ColorFiltered(
                  colorFilter:  ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn
                  ),
                  child: Image.asset(
                      fit: BoxFit.contain,
                      'assets/images/download_icon.png'
                  ),

                )
            ),
          ),
        ],
      ),
      body: Consumer<DetailStoryViewModel>(
        builder: (context, storyDetailViewModel, _) {
          if (storyDetailViewModel.story == null || storyDetailViewModel.chapterPagination == null ) {
            return Center(child: CircularProgressIndicator());
          } else {
            final story = storyDetailViewModel.story!;
            //initDescription(story.description);
            final chapter = storyDetailViewModel.chapterPagination!;
            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.yellow, // Màu của đường viền
                                  width: 2, // Độ rộng của đường viền
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(story.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/images/default_image.png',
                                    height: 140,
                                    width: 84,
                                  );
                                },),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${story.name}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Thể loại: ${story.categories?.first.content}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),

                                  ),
                                  Text(
                                    'Số chương: ${chapter.maxChapter}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),

                                  ),
                                  Text(
                                    'Tác giả: ${story.author}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // Text(
                                  //     '${story.link}',
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //     ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            width: 130,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.yellow, // Màu của đường viền
                                width: 1.5, // Độ rộng của đường viền
                              ),
                              borderRadius: BorderRadius.circular(10), // Độ cong của góc viền
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                value: selectedItem,
                                items: items.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        value
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() async {
                                    if (newValue != null) {
                                      bool fetchResult = await onSourceChange(story.name,newValue);

                                      if (fetchResult==true) {
                                        int newIndex = items.indexOf(newValue);
                                        items.insert(
                                            0, items.removeAt(newIndex));
                                        selectedItem = newValue;
                                        selectedIndex = 0;
                                        selectedItem = newValue;
                                      }

                                    }

                                  });
                                },
                                hint: Text(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    '${items[0]}'
                                ),
                                dropdownColor: Colors.black54,
                              ),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 550,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 1.0,
                            ),
                          ),

                          child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            _isBtnDescribePressed = true;
                                            _isBtnChapterPressed = false;
                                            _currentData = SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('${story.description}'),
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _isBtnDescribePressed ? Colors.red : Colors.black,
                                              fontSize: 16,
                                            ),
                                            'Mô tả'
                                        )
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            _isBtnDescribePressed = false;
                                            _isBtnChapterPressed = true;
                                            _currentData = Column(
                                              children: [
                                                Expanded(
                                                  child: Consumer<DetailStoryViewModel>(
                                                      builder: (context, chapterListViewModel, _) {
                                                      if (chapterListViewModel.chapterPagination == null || chapterListViewModel.chapterPagination?.listChapter == null) {
                                                        return Center(child: CircularProgressIndicator());
                                                      } else {
                                                        return ListView.builder(
                                                          itemCount: chapterListViewModel.chapterPagination?.listChapter?.length,
                                                          itemBuilder: (context, index) {
                                                            final chapter_page = chapterListViewModel.chapterPagination!.listChapter?[index];
                                                            return ListTile(
                                                              title: Text(chapter_page!.content),
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => ChangeNotifierProvider(
                                                                        create: (context) => ContentStoryViewModel(),
                                                                        child:  ContentStoryScreen(
                                                                          storyTitle: widget.storyTitle,
                                                                          name: storyDetailViewModel.story!.name,
                                                                          chap:  (_currentPage-1) * _perPage +(index +1),
                                                                          dataSource: widget.datasource,
                                                                          pageNumber: _currentPage,)
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Consumer<DetailStoryViewModel>(
                                                  builder: (context, chapterListViewModel, _) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(Icons.arrow_back),
                                                          onPressed: _currentPage == 1
                                                              ? null
                                                              : () {
                                                            setState(() {
                                                              _currentPage--;
                                                              _fetchChapters();
                                                            });
                                                          },
                                                        ),
                                                        Text('Page $_currentPage'),
                                                        IconButton(
                                                          icon: Icon(Icons.arrow_forward),
                                                          onPressed: _currentPage * _perPage >= chapter.maxChapter
                                                              ? null
                                                              : () {
                                                            setState(() {
                                                              _currentPage++;
                                                              _fetchChapters();
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                          );
                                        },
                                        child: Text(
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _isBtnChapterPressed ? Colors.red : Colors.black,
                                              fontSize: 16,
                                            ),
                                            'Chương'
                                        )
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    height: 430,
                                    width: 380,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: _currentData,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChangeNotifierProvider(
                                            create: (_) => ContentStoryViewModel(),
                                            child: ContentStoryScreen(
                                              storyTitle: storyDetailViewModel.story?.title != null ?
                                                          storyDetailViewModel.story!.title
                                                              : "",
                                              name:  storyDetailViewModel.story?.name != null ?
                                                      storyDetailViewModel.story!.name
                                                        : "",
                                              chap: 1,
                                              dataSource: items[0],
                                              pageNumber: 1,),
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          'Bắt đầu đọc'
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          )
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

