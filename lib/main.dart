import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/StoryViewModel.dart';
import 'Models/Story.dart';
import 'login_view.dart';
import 'register_view.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StoryViewModel _storyViewModel = StoryViewModel();
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MVVM Flutter App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _storyViewModel.fetchStory(),
              child: Text('Fetch Stories'),
            ),
            Expanded(
              child: StreamBuilder<List<Story>>(
                stream: _storyViewModel.storyStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final stories = snapshot.data;
                    return ListView.builder(
                      itemCount: stories?.length,
                      itemBuilder: (context, index) {
                        final story = stories?[index];
                        return ListTile(
                          title: Text(story!.name),
                          subtitle: Text('Cover: ${story?.cover}'),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

