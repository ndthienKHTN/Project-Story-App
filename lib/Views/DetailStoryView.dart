import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

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