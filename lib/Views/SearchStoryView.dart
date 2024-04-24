import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/StoryService.dart';
import '../ViewModels/DetailStoryViewModel.dart';
import '../ViewModels/SearchStoryViewModel.dart';
import 'DetailStoryView.dart';
import '../ViewModels/DetailStoryViewModel.dart';
import '../ViewModels/SearchStoryViewModel.dart';
import 'Components_DetailStory/DetailStoryView_temp.dart';

class SearchScreen extends StatefulWidget {
  late String searchQuery;
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchStoryViewModel _searchStoryViewModel;
  late String searchQuery;
  @override
  void initState() {
    super.initState();
    _searchStoryViewModel = Provider.of<SearchStoryViewModel>(context, listen: false);

    _searchStoryViewModel.fetchSearchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () => {new StoryService().fetchListCategory("Truyen123")},
                    child: Text('list categories'))
              ],
            ),
          ),
          Expanded(
            child:Consumer<SearchStoryViewModel>(
              builder: (context, storyListViewModel, _) {
                if (storyListViewModel.stories.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: storyListViewModel.stories.length,
                    itemBuilder: (context, index) {
                      final story = storyListViewModel.stories[index];
                      return ListTile(
                        title: Text(story.name),
                        subtitle: Text(story.link),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => DetailStoryViewModel(),
                                child: DetailStoryScreen(storyTitle: 'need to change',),
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
        ],
      ),

    );
  }
}

