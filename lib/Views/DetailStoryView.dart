import 'package:flutter/material.dart';
import 'package:project_login/Views/DownloadChaptersView.dart';
import 'package:provider/provider.dart';
import '../Models/Story.dart';
import '../ViewModels/ContentStoryViewModel.dart';
import '../ViewModels/DetailStoryViewModel.dart';
import 'ContentStoryView.dart';

class DetailStoryScreen extends StatefulWidget {
  final String storyTitle;

  const DetailStoryScreen({required this.storyTitle});

  @override
  _DetailStoryScreenState createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  late DetailStoryViewModel _detailStoryViewModel;

  @override
  void initState() {
    super.initState();
    _detailStoryViewModel = Provider.of<DetailStoryViewModel>(context, listen: false);
    //_fetchStoryDetails();
    _detailStoryViewModel.fetchDetailsStory(widget.storyTitle);
    _detailStoryViewModel.fetchChapterPagination(widget.storyTitle);
  }

  Future<void> _fetchStoryDetails() async {
    await _detailStoryViewModel.fetchDetailsStory(widget.storyTitle);
  }
  bool _isBtnDescribePressed = false;
  bool _isBtnChapterPressed = false;
  String ? selectedItem ;
  int _chapterCount = 6;
  Widget _currentData = Text('Example');

  final List<String> items = [
    'TruyenFull',
    'Truyen123',
    'TruyenMoi'
  ];

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
            // Xử lý sự kiện khi nút "Back" được nhấn
            Navigator.of(context).pop(); // Quay lại trang trước đó
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DownloadChapters()),
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
          if (storyDetailViewModel.story == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            final story = storyDetailViewModel.story!;
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
                                  width: 2.5, // Độ rộng của đường viền
                                ),
                              ),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                    'assets/images/naruto.jpg'
                                ),
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
                                    'Thể loại: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),

                                  ),
                                  Text(
                                    'Số chương: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),

                                  ),
                                  Text(
                                    'Tác giả: ',
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
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.yellow, // Màu của đường viền
                                width: 2, // Độ rộng của đường viền
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
                                    selectedItem = newValue;
                                  });
                                },
                                hint: Text(
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    '${items[0]}'
                                ),
                                dropdownColor: Colors.grey,
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
                                            _currentData = Text('Example');
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
                                            _currentData = ListView.builder(
                                              itemCount: _chapterCount,
                                              itemBuilder: (context,index) {
                                                return ListTile(
                                                  title: Text('$index. Chương $index: '),
                                                );
                                              },
                                            );
                                          });
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
                                            child: ContentStoryScreen(storyTitle: storyDetailViewModel.story?.title != null ? storyDetailViewModel.story!.title : "", chap: '10', dataSource: 'Truyenfull', pageNumber: 1,),
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