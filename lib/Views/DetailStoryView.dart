import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'package:project_login/Views/DownloadChaptersView.dart';
import 'package:provider/provider.dart';
import '../Models/Chapter.dart';
import '../Models/Story.dart';
import '../ViewModels/ContentStoryViewModel.dart';
import '../ViewModels/DetailStoryViewModel.dart';
import '../ViewModels/DownloadChatersViewModel.dart';
import 'ContentStoryView.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';

class DetailStoryScreen extends StatefulWidget {
  final String storyTitle;
  final String datasource;
  const DetailStoryScreen({super.key, required this.storyTitle,required this.datasource});

  @override
  _DetailStoryScreenState createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  late DetailStoryViewModel _detailStoryViewModel;
  late HomeStoryViewModel _homeStoryViewModel;
  int _currentPage = 1;
  final int _perPage = 50; // Số lượng mục trên mỗi trang
  // Trang hiện tại
  bool _isBtnDescribePressed = false;
  bool _isBtnChapterPressed = false;
  String ? selectedItem ;
  late int selectedIndex;
  Widget ?_currentData ;
  late List<String> items =[];
  void _fetchChapters() {
    _detailStoryViewModel.fetchChapterPagination(widget.storyTitle, _currentPage, widget.datasource);
  }
  void _fetchDatasource(){
      for(int i=0;i<_homeStoryViewModel.sourceBooks.length;i++){
        items.add(_homeStoryViewModel.sourceBooks[i]);
      }
  }
  @override
  void initState() {
    super.initState();
    _detailStoryViewModel = Provider.of<DetailStoryViewModel>(context, listen: false);
    _detailStoryViewModel.fetchDetailsStory(widget.storyTitle, widget.datasource);
    _homeStoryViewModel = Provider.of<HomeStoryViewModel>(context,listen: false);
    _fetchChapters();
    _fetchDatasource();
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
                  create: (_) => DownloadChaptersViewModel(),
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
          if (storyDetailViewModel.story == null || storyDetailViewModel.chapterPagination == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            final story = storyDetailViewModel.story!;
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
                                child: Image(image: NetworkImage(story.cover)),
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
                                  setState(() {
                                    if (newValue != null) {
                                      int newIndex = items.indexOf(newValue);
                                      items.insert(0, items.removeAt(newIndex));
                                      selectedItem = newValue;
                                      selectedIndex = 0;
                                    }
                                    selectedItem = newValue;
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
                                                      if (chapterListViewModel.chapterPagination == null) {
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
                                                                          title: storyDetailViewModel.story!.title,
                                                                          chap: index+1,
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
                                              title:  storyDetailViewModel.story?.name != null ?
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
/* return Scaffold(
      appBar: AppBar(
        title: Text('Story Detail'),
      ),
      body: Consumer<DetailStoryViewModel>(
        builder: (context, storyDetailViewModel, _) {
          if (storyDetailViewModel.story == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            final story = storyDetailViewModel.story!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${story.name}'),
                Text('Description: ${story.link}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (_) => ContentStoryViewModel(),
                          child: ContentStoryScreen(storyTitle: storyDetailViewModel.story?.name != null ? storyDetailViewModel.story!.name : ""),
                        ),
                      ),
                    );
                  },
                  child: Text('Read'),
                ),
                Expanded(
                    child: Consumer<DetailStoryViewModel>(
                      builder: (context, chapterListViewModel, _) {
                        if (chapterListViewModel.chapterPagination == null) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            itemCount: chapterListViewModel.chapterPagination?.listChapter?.length,
                            itemBuilder: (context, index) {
                              final chapter = chapterListViewModel.chapterPagination!.listChapter?[index];
                              return ListTile(
                                title: Text(chapter!.content),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider(
                                            create: (context) => ContentStoryViewModel(),
                                            child:  ContentStoryScreen(storyTitle: chapter.content)
                                        ),
                                      ),
                                  );
                                },

                              );
                            },
                          );
                        }
                      },
                    )
                )
              ],

            );
          }
        },
      ),
    );*/
/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Details'),
      ),
      body: Consumer<DetailStoryViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.story != null) {
            // Display story details
            final story = viewModel.story!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${story.name}'),
                  Text('Cover: ${story.cover}'),
                  // Add more story details here
                ],
              ),
            );
          } else {
            // Loading indicator
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }*/

/*
class StoryDetailScreen extends StatelessWidget {
  final Story story;

  const StoryDetailScreen({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.name),
      ),
      body: Center(
        child: Text('Story details'),
      ),
    );
  }
}*/