import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/DetailStoryViewModel.dart';
import 'package:project_login/Views/DetailStoryView.dart';
import 'package:provider/provider.dart';
import '../Models/Story.dart';
import '../ViewModels/HomeStoryViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStoryViewModel _homeStoryViewModel;
  @override
  void initState() {
    super.initState();
    _homeStoryViewModel = Provider.of<HomeStoryViewModel>(context, listen: false);
    //TODO: need to change
    _homeStoryViewModel.fetchHomeStories("Truyenfull");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:
      Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10,right: 8),
                height: 36,
                width: 320,
                child:  TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      prefixIconColor: Colors.grey,
                      suffixIcon: const Icon(Icons.play_arrow),
                      suffixIconColor: Colors.grey,
                      hintText: 'Search here...',
                      contentPadding: const EdgeInsets.only(top: 2),
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )
                  ),
                ),
              ),
              const Icon(
                Icons.filter_list_sharp,
                color: Colors.white,),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10
            ),
            alignment: Alignment.centerLeft,
            child: const ListSourceBook(),
          ),
          Container(
            color: Colors.black,
            child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text((Provider.of<HomeStoryViewModel>(context).sourceBook),style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                  const Spacer(),
                  const ListOrGridbuttom()
                ]
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: ListorGrid()
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListSourceBook extends StatelessWidget {
  const ListSourceBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStoryViewModel>(builder: (context,storyListViewModel,_){
      if (storyListViewModel.stories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < storyListViewModel.sourceBooks.length; i++)
                GestureDetector(
                  onTap: () {
                    Provider.of<HomeStoryViewModel>(context,listen: false).ChangeIndex(i);
                    storyListViewModel.ChangeSourceBook(storyListViewModel.sourceBooks[i]);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Provider.of<HomeStoryViewModel>(context).indexSourceBook==i ? Colors.red : Colors.yellow, width: 2),
                    ),
                    child: Text(
                      storyListViewModel.sourceBooks[i],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      }
    });
  }
}

class ListOrGridbuttom extends StatefulWidget {
  const ListOrGridbuttom({super.key});

  @override
  State<ListOrGridbuttom> createState() => _ListOrGridbuttomState();
}

class _ListOrGridbuttomState extends State<ListOrGridbuttom> {
  bool isListButtonPressed = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isListButtonPressed = true; // Đặt trạng thái nút danh sách được nhấn
                Provider.of<HomeStoryViewModel>(context,listen: false).ChangeListOrGrid(true);
              });
            },
            child: Icon(
              Icons.list,
              color: isListButtonPressed ? Colors.red : Colors.white, // Thay đổi màu sắc dựa trên trạng thái của nút
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isListButtonPressed = false;
                Provider.of<HomeStoryViewModel>(context,listen: false).ChangeListOrGrid(false);// Đặt trạng thái nút danh sách không được nhấn
              });
            },
            child: Icon(
              Icons.grid_on_sharp,
              color: isListButtonPressed ? Colors.white : Colors.red, // Thay đổi màu sắc dựa trên trạng thái của nút
            ),
          ),
        ),
      ],
    );
  }
}

class ListorGrid extends StatefulWidget {
  const ListorGrid({super.key});

  @override
  State<ListorGrid> createState() => _ListorGridState();
}

class _ListorGridState extends State<ListorGrid> {

  @override
  Widget build(BuildContext context) {
    return Provider.of<HomeStoryViewModel>(context).listOn ? const ListViewBook(): const GridViewBook();
  }
}

class ListViewBook extends StatelessWidget {
  const ListViewBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStoryViewModel>(
      builder: (context,storyNotifier,_){
        if (storyNotifier.stories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Story> listStories=storyNotifier.stories['full']!;
          return  ListView.builder(
            itemCount: listStories.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => DetailStoryViewModel(),
                            child: DetailStoryScreen(storyTitle: listStories[index].title, datasource: storyNotifier.sourceBook,),
                          )
                      )
                  );
                },
                child:  Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.yellow, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image(image: NetworkImage(listStories[index].cover), height: 101, width: 84),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 241,
                                child: Text(
                                  listStories[index].name,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'By: ${listStories[index].author}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    for (int j = 0; j < (listStories[index].categories!.length < 3 ? listStories[index].categories!.length : 3); j++)
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 3),
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.white, width: 1),
                                        ),
                                        child: Text(
                                          listStories[index].categories![j].content,
                                          style: const TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              );

            },
          );
        }
      },
    );
  }
}

class GridViewBook extends StatelessWidget {
  const GridViewBook({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStoryViewModel>(
      builder: (context,storyNotifier,_){
        if (storyNotifier.stories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Story> listStories = storyNotifier.stories['full']!;
          return GridView.builder(
            itemCount: listStories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Số lượng cột trong grid view
              mainAxisSpacing: 10, // Khoảng cách giữa các hàng
              childAspectRatio: 110/150, // Tỷ lệ giữa chiều rộng và chiều cao của mỗi item
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: Image(
                        image: NetworkImage(listStories[index].cover),
                        height: 120,
                        width: 110,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 99,
                          child: Text(
                            listStories[index].name,
                            style: const TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            'By: ${listStories[index].author}',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}