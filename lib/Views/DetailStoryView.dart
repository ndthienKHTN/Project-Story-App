import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Story.dart';
import '../ViewModels/DetailStoryViewModel.dart';
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


class StoryDetailScreen extends StatefulWidget {
  final String storyTitle;

  const StoryDetailScreen({required this.storyTitle});

  @override
  _StoryDetailScreenState createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late DetailStoryViewModel _detailStoryViewModel;

  @override
  void initState() {
    super.initState();
    _detailStoryViewModel = Provider.of<DetailStoryViewModel>(context, listen: false);
    _fetchStoryDetails();
  }

  Future<void> _fetchStoryDetails() async {
    await _detailStoryViewModel.fetchStoryDetails(widget.storyTitle);
  }

  @override
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
  }
}